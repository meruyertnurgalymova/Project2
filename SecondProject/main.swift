//
//  main.swift
//  SecondProject
//
//  Created by Nuegalymova Meruyert on 09.06.2023.
//


protocol Account {
    var accountNumber: String { get }
    var balance: Double { get set }
    var currency: String { get }
    
    func deposit(amount: Double)
    func withdraw(amount: Double) -> Bool
}


protocol Card {
    var cardNumber: String { get }
    var pinCode: String { get set }
    
    func block()
    func changePin(newPin: String)
}


class CurrencyAccount: Account {
    var accountNumber: String
    var balance: Double = 0.0
    var currency: String
    
    init(accountNumber: String, currency: String) {
        self.accountNumber = accountNumber
        self.currency = currency
    }
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) -> Bool {
        if balance >= amount {
            balance -= amount
            return true
        }
        return false
    }
}


class BankCard: Card {
    var cardNumber: String
    var pinCode: String
    
    init(cardNumber: String, pinCode: String) {
        self.cardNumber = cardNumber
        self.pinCode = pinCode
    }
    
    func block() {
        // Логика блокировки карты
    }
    
    func changePin(newPin: String) {
        pinCode = newPin
    }
}

// Класс приложения
class BankingApp {
    var accounts: [Account] = []
    var cards: [Card] = []
    
    func openAccount(accountNumber: String, currency: String) -> CurrencyAccount {
        let account = CurrencyAccount(accountNumber: accountNumber, currency: currency)
        accounts.append(account)
        return account
    }
    
    func closeAccount(account: Account) {
        accounts.removeAll { $0.accountNumber == account.accountNumber }
    }
    
    func transfer(fromAccount: Account, toAccount: Account, amount: Double) {
        guard fromAccount.withdraw(amount: amount) else {
            print("Insufficient balance")
            return
        }
        
        toAccount.deposit(amount: amount)
        print("Transfer successful")
    }
    
    func blockCard(card: Card) {
        card.block()
        print("Card blocked")
    }
    
    func changeCardPin(card: Card, newPin: String) {
        card.changePin(newPin: newPin)
        print("PIN changed")
    }
    
    func printAccountInfo(account: Account) {
        print("Account Number: \(account.accountNumber)")
        print("Balance: \(account.balance)")
        print("Currency: \(account.currency)")
    }
    
    func printCardInfo(card: Card) {
        print("Card Number: \(card.cardNumber)")
    }
}


let app = BankingApp()

let account1 = app.openAccount(accountNumber: "123456", currency: "USD")
let account2 = app.openAccount(accountNumber: "987654", currency: "EUR")

account1.deposit(amount: 1000.0)
account2.deposit(amount: 500.0)

app.printAccountInfo(account: account1)
app.printAccountInfo(account: account2)

app.printAccountInfo(account: account1)
app.printAccountInfo(account: account2)

let card1 = BankCard(cardNumber: "1234567890", pinCode: "1234")
let card2 = BankCard(cardNumber: "9876543210", pinCode: "5678")

app.blockCard(card: card1)
app.blockCard(card: card2)

app.changeCardPin(card: card1, newPin: "4321")
app.changeCardPin(card: card2, newPin: "8765")


app.printCardInfo(card: card1)
app.printCardInfo(card: card2)


