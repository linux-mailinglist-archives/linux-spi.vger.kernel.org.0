Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE91309EF
	for <lists+linux-spi@lfdr.de>; Sun,  5 Jan 2020 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAEUr2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 Jan 2020 15:47:28 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38292 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAEUr2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 5 Jan 2020 15:47:28 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3A938891AA
        for <linux-spi@vger.kernel.org>; Mon,  6 Jan 2020 09:47:23 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1578257243;
        bh=ujJ6PLwvmoRFhsx+EuB6+M+b4BNJr04Hd9eIjBvPh5I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=iSsP4k1F0rl+O7u7WqFn86Ebn4BjUmhS+uVpuMEb+C38HEUBAGox5sZ6+4hzSiniG
         Mj3/qmbpyHoiGAiL2tAPb0G6p+8t40MEieK9iv2Noh0BZMf0O/YJ7K1QcYAObbXO4m
         t2HU6uDxwbRnjQzxGj7od/ItKM0ifRdihdTxLCv8eGsajogMSg5tlsWL4NztHdDiU3
         nkF/0qHp2BVRxIC+clxyje+D2MJuhyyMLfka804ISZqWvWUaM+bFfW1DIXiUF7ThKg
         U2GMdfIba9Ig9vOSi1YScgURwCdNxRzZxp1CWa+B++COPhWY2MIiH5ZVb1WrcPMGBB
         prA73TJScb+wQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e124b5b0000>; Mon, 06 Jan 2020 09:47:23 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jan 2020 09:47:21 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Mon, 6 Jan 2020 09:47:21 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "anthony.derosa@syscall7.com" <anthony.derosa@syscall7.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Multiplex SPI Chip Selects
Thread-Topic: Multiplex SPI Chip Selects
Thread-Index: AQHVwK6/lje3qJHLR02SM15vWygu1Kfbt1oA
Date:   Sun, 5 Jan 2020 20:47:21 +0000
Message-ID: <a0171241162171ffac6429d29edfaa83fbd9a2ba.camel@alliedtelesis.co.nz>
References: <CAB595VxuL+iOQD3Re1PbjP50GD51XuMML8_R6Ku2ywAAHcOcdw@mail.gmail.com>
In-Reply-To: <CAB595VxuL+iOQD3Re1PbjP50GD51XuMML8_R6Ku2ywAAHcOcdw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:c962:f54a:1016:4843]
Content-Type: text/plain; charset="utf-8"
Content-ID: <405D73046445A1408878CC48B293A181@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgQW50aG9ueSwNCg0KT24gV2VkLCAyMDIwLTAxLTAxIGF0IDA5OjIxIC0wNTAwLCBBbnRob255
IERlUm9zYSB3cm90ZToNCj4gSGkgQ2hyaXMsDQo+IA0KPiBJIHNhdyB5b3VyIHRocmVhZFsxXSBh
Ym91dCBtdWx0aXBsZXhpbmcgY2hpcCBzZWxlY3RzIG9uIHRoZSBTUEkgYnVzDQo+IGFuZCB3b25k
ZXJlZCB3aGF0IHNvbHV0aW9uIHlvdSBzZXR0bGVkIG9uIGluIHRoZSBlbmQuIExvb2tzIGxpa2Ug
eW91cg0KPiBwYXRjaCB3YXMgbm90IGludGVncmF0ZWQgaW50byB0aGUga2VybmVsLCBpcyB0aGF0
IHJpZ2h0PyBJIGhhdmUgYQ0KPiBzaW1pbGFyIHByb2JsZW0gd2hlcmUgSSBuZWVkIHRvIHVzZSBH
UElPcyB0byBtdWx0aXBsZXggdGhlIENTMCBwaW4gb24NCj4gYSByYXNwYmVycnkgcGkuIEFueSBp
bnNpZ2h0cyB3b3VsZCBiZSBhcHByZWNpYXRlZC4NCj4gDQoNCkZvciB0aGUgc2ltcGxlIGNhc2Ug
dGhlIGV4aXN0aW5nIGNzLWdwaW9zIHN1cHBvcnQgd29ya3Mgd2VsbC4gU28gdXNpbmcNCnRoYXQg
aWYgeW91IGNhbiBpcyBteSByZWNvbW1lbmRhdGlvbi4NCg0KVW5mb3J0dW5hdGVseSBmb3IgbWUg
aXQncyBub3QgdGhhdCBzaW1wbGUgYmVjYXVzZSBJIGhhdmUgMiBwbGF0Zm9ybXMNCndoaWNoIG5l
ZWQgYm90aCB0aGUgZ3BpbyBDUyBhbmQgdGhlIG5hdGl2ZSBDUzAuIFRoaXMgaXMgd2hlcmUgdGhp
bmdzDQpnZXQgYSBiaXQgdHJpY2t5Lg0KDQpUaGUgZXhpc3RpbmcgY29kZSB3aWxsIGludmVydCB0
aGUgbmF0aXZlIENTMCAoYmVjYXVzZSBTUElfQ1NfSElHSCBpcw0Kc2V0KSBJIHRoaW5rIHRoaXMg
aXMgYSBzdHJhaWdodCBjb3JuZXItY2FzZSBidWcgYW5kIHdlIHNob3VsZCBlaXRoZXINCm5vdCBp
bnZlcnQgdGhlIG5hdGl2ZSBDUzAgb3IgaGF2ZSBhIHNlcGFyYXRlIGZsYWcgdG8gaW5kaWNhdGUg
d2hlbiB0aGUNCm5hdGl2ZSBDUzAgbmVlZHMgaW52ZXJ0aW5nLg0KDQpGb3IgdGhlIDIgcGxhdGZv
cm1zIEknbSBkZWFsaW5nIHdpdGggSSBoYXZlIGEgY29tcGxpY2F0aW9uIGluIHRoZSBIVw0KZGVz
aWduIHdoZXJlIHRoZSBncGlvIGlzIHVzZWQgdG8gc3RlZXIgdGhlIG5hdGl2ZSBDUzAgKGFzIG9w
cG9zZWQgdG8NCnJlcGxhY2luZyBpdCkgd2hpY2ggaXMgd2hhdCBteSBvcmlnaW5hbCBzZXJpZXMg
YXR0ZW1wdGVkIHRvIGRlYWwgd2l0aC4NCkkgZW5kZWQgdXAgaW1wbGVtZW50aW5nIGEgZ3Bpby1v
dmVyLWdwaW8gY29udHJvbGxlciB0aGF0IHByZXNlbnRlZCAyDQp2aXJ0dWFsIGdwaW9zIHdoaWNo
IHJlZmxlY3RlZCB0aGUgaGlnaC1sb3cgc3RhdGUgb2YgYSBzaW5nbGUgcGh5c2ljYWwNCmdwaW8g
KGJhc2ljYWxseSBpbXBsZW1lbnRlZCBNYXJrJ3Mgc3VnZ2VzdGlvbiBmcm9tIHRoZSB0aHJlYWQp
LiBJDQpoYXZlbid0IGF0dGVtcHRlZCB0byB1cHN0cmVhbSB0aGUgZHJpdmVyIGJlY2F1c2UgSSBj
b25zaWRlciBpdCBhIFNXIGZpeA0KZm9yIHF1aXJrIG9mIG91ciBIVyBkZXNpZ25zLCBidXQgaWYg
dGhlcmUgaXMgaW50ZXJlc3QgSSBjb3VsZCBhdCBsZWFzdA0Kc2VuZCBpdCBvdXQuDQoNClJlZ2Fy
ZHMsDQpDaHJpcw0KDQotLQ0KWzFdIC0gDQpodHRwczovL2x3bi5uZXQvbWwvZGV2aWNldHJlZS8y
MDE5MDQxMjA1MDIxMy4xNzY5OC0xLWNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uei8N
Cg==
