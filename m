Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3EB3E8A29
	for <lists+linux-spi@lfdr.de>; Wed, 11 Aug 2021 08:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhHKGVj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Aug 2021 02:21:39 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50211 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhHKGVi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Aug 2021 02:21:38 -0400
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 17B6L6MJ059206;
        Wed, 11 Aug 2021 14:21:06 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 8B92F9B29CE7BF2BB481;
        Wed, 11 Aug 2021 14:21:07 +0800 (CST)
In-Reply-To: <20210810122104.GB4704@sirena.org.uk>
References: <1628584186-9266-1-git-send-email-zhengxunli@mxic.com.tw> <20210810122104.GB4704@sirena.org.uk>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH v8] spi: mxic: patch for octal DTR mode support
MIME-Version: 1.0
X-KeepSent: 2C0E2D41:34073C33-4825872E:0022CE58;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF2C0E2D41.34073C33-ON4825872E.0022CE58-4825872E.0022E499@mxic.com.tw>
From:   zhengxunli@mxic.com.tw
Date:   Wed, 11 Aug 2021 14:21:07 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/08/11 PM 02:21:07,
        Serialize complete at 2021/08/11 PM 02:21:07
Content-Type: text/plain; charset="Big5"
Content-Transfer-Encoding: base64
X-MAIL: TWHMLLG3.macronix.com 17B6L6MJ059206
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


SGkgTWFyaywNCg0KIk1hcmsgQnJvd24iIDxicm9vbmllQGtlcm5lbC5vcmc+IHdyb3RlIG9uIDIw
MjEvMDgvMTAgpFWkyCAwODoyMTowNDoNCg0KPiAiTWFyayBCcm93biIgPGJyb29uaWVAa2VybmVs
Lm9yZz4gDQo+IDIwMjEvMDgvMTAgpFWkyCAwODoyMQ0KPiANCj4gVG8NCj4gDQo+ICJaaGVuZ3h1
biBMaSIgPHpoZW5neHVubGlAbXhpYy5jb20udHc+LCANCj4gDQo+IGNjDQo+IA0KPiBsaW51eC1z
cGlAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBTdWJqZWN0DQo+IA0KPiBSZTogW1BBVENIIHY4XSBz
cGk6IG14aWM6IHBhdGNoIGZvciBvY3RhbCBEVFIgbW9kZSBzdXBwb3J0DQo+IA0KPiBPbiBUdWUs
IEF1ZyAxMCwgMjAyMSBhdCAwNDoyOTo0NlBNICswODAwLCBaaGVuZ3h1biBMaSB3cm90ZToNCj4g
PiBEcml2ZXIgcGF0Y2ggZm9yIG9jdGFsIERUUiBtb2RlIHN1cHBvcnQuDQo+ID4gDQo+ID4gT3dp
bmcgdG8gdGhlIHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcCgpIGlzIG5vdCBzdXBwb3J0IGR0
cg0KPiA+IG9wZXJhdGlvbi4gQmFzZWQgb24gY29tbWl0IDw1MzljZjY4Y2Q1MWI+IChzcGk6IHNw
aS1tZW06IGFkZA0KPiA+IHNwaV9tZW1fZHRyX3N1cHBvcnRzX29wKCkpIGFkZCBzcGlfbWVtX2R0
cl9zdXBwb3J0c19vcCgpDQo+ID4gdG8gc3VwcG9ydCBkdHIgYW5kIGtlZXAgY2hlY2tpbmcgdGhl
IGJ1c3dpZHRoIGFuZCBjb21tYW5kIGJ5dGVzLg0KPiANCj4gUGxlYXNlIGRvIG5vdCBzdWJtaXQg
bmV3IHZlcnNpb25zIG9mIGFscmVhZHkgYXBwbGllZCBwYXRjaGVzLCBwbGVhc2UNCj4gc3VibWl0
IGluY3JlbWVudGFsIHVwZGF0ZXMgdG8gdGhlIGV4aXN0aW5nIGNvZGUuICBNb2RpZnlpbmcgZXhp
c3RpbmcNCj4gY29tbWl0cyBjcmVhdGVzIHByb2JsZW1zIGZvciBvdGhlciB1c2VycyBidWlsZGlu
ZyBvbiB0b3Agb2YgdGhvc2UNCj4gY29tbWl0cyBzbyBpdCdzIGJlc3QgcHJhY3RpY2UgdG8gb25s
eSBjaGFuZ2UgcHViaXNoZWQgZ2l0IGNvbW1pdHMgaWYNCj4gYWJzb2x1dGVseSBlc3NlbnRpYWwu
DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KVGhhbmtzLA0KWmhlbmd4dW4NCg0KQ09O
RklERU5USUFMSVRZIE5PVEU6DQoNClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5
IGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIA0KYW5kL29yIHBlcnNvbmFsIGRhdGEs
IHdoaWNoIGlzIHByb3RlY3RlZCBieSBhcHBsaWNhYmxlIGxhd3MuIFBsZWFzZSBiZSANCnJlbWlu
ZGVkIHRoYXQgZHVwbGljYXRpb24sIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9m
IHRoaXMgZS1tYWlsIA0KKGFuZC9vciBpdHMgYXR0YWNobWVudHMpIG9yIGFueSBwYXJ0IHRoZXJl
b2YgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgDQp0aGlzIGUtbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB1cyBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoaXMgbWFpbCBhcyANCndl
bGwgYXMgaXRzIGF0dGFjaG1lbnQocykgZnJvbSB5b3VyIHN5c3RlbS4gSW4gYWRkaXRpb24sIHBs
ZWFzZSBiZSANCmluZm9ybWVkIHRoYXQgY29sbGVjdGlvbiwgcHJvY2Vzc2luZywgYW5kL29yIHVz
ZSBvZiBwZXJzb25hbCBkYXRhIGlzIA0KcHJvaGliaXRlZCB1bmxlc3MgZXhwcmVzc2x5IHBlcm1p
dHRlZCBieSBwZXJzb25hbCBkYXRhIHByb3RlY3Rpb24gbGF3cy4gDQpUaGFuayB5b3UgZm9yIHlv
dXIgYXR0ZW50aW9uIGFuZCBjb29wZXJhdGlvbi4NCg0KTWFjcm9uaXggSW50ZXJuYXRpb25hbCBD
by4sIEx0ZC4NCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQoNCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCkNP
TkZJREVOVElBTElUWSBOT1RFOg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1h
eSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQvb3IgcGVyc29uYWwgZGF0YSwg
d2hpY2ggaXMgcHJvdGVjdGVkIGJ5IGFwcGxpY2FibGUgbGF3cy4gUGxlYXNlIGJlIHJlbWluZGVk
IHRoYXQgZHVwbGljYXRpb24sIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRo
aXMgZS1tYWlsIChhbmQvb3IgaXRzIGF0dGFjaG1lbnRzKSBvciBhbnkgcGFydCB0aGVyZW9mIGlz
IHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ug
bm90aWZ5IHVzIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgdGhpcyBtYWlsIGFzIHdlbGwgYXMgaXRz
IGF0dGFjaG1lbnQocykgZnJvbSB5b3VyIHN5c3RlbS4gSW4gYWRkaXRpb24sIHBsZWFzZSBiZSBp
bmZvcm1lZCB0aGF0IGNvbGxlY3Rpb24sIHByb2Nlc3NpbmcsIGFuZC9vciB1c2Ugb2YgcGVyc29u
YWwgZGF0YSBpcyBwcm9oaWJpdGVkIHVubGVzcyBleHByZXNzbHkgcGVybWl0dGVkIGJ5IHBlcnNv
bmFsIGRhdGEgcHJvdGVjdGlvbiBsYXdzLiBUaGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uIGFu
ZCBjb29wZXJhdGlvbi4NCg0KTWFjcm9uaXggSW50ZXJuYXRpb25hbCBDby4sIEx0ZC4NCg0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo=

