Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E40355D3A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jun 2019 03:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFZBG6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Jun 2019 21:06:58 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:48645 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZBG6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Jun 2019 21:06:58 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x5Q16cti017312;
        Wed, 26 Jun 2019 09:06:38 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 385FD1B2CB53599BD566;
        Wed, 26 Jun 2019 09:06:38 +0800 (CST)
In-Reply-To: <c8dab2f7-3ddb-497a-bb14-dded31930ce6@cogentembedded.com>
References: <20190612090552.GD4797@dell> <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com> <20190617093048.GD16364@dell> <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com> <20190618091955.GN16364@dell> <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com> <20190618095741.GA18371@dell> <ff85a907-8f26-5e80-c7f0-655ca11afe25@cogentembedded.com> <20190619061659.GH18371@dell> <OFB918AE65.CB02BB75-ON4825841E.0025C688-4825841E.00265891@mxic.com.tw> <20190619075422.GJ18371@dell> <c8dab2f7-3ddb-497a-bb14-dded31930ce6@cogentembedded.com>
To:     "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Cc:     "Mark Brown" <broonie@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>,
        "linux-spi" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
MIME-Version: 1.0
X-KeepSent: 29A041F3:432D8EC4-48258425:00047895;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF29A041F3.432D8EC4-ON48258425.00047895-48258425.00061A38@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 26 Jun 2019 09:06:39 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/26 AM 09:06:38,
        Serialize complete at 2019/06/26 AM 09:06:38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-MAIL: TWHMLLG4.macronix.com x5Q16cti017312
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


SGVsbG8sIA0KDQo+IFJlOiBbUEFUQ0ggUkZDIDIvMl0gbWZkOiBhZGQgUmVuZXNhcyBSUEMtSUYg
ZHJpdmVyDQo+IA0KPiBPbiAwNi8xOS8yMDE5IDEwOjU0IEFNLCBMZWUgSm9uZXMgd3JvdGU6DQo+
IA0KPiA+Pj4+PiBMb29rcyBsaWtlIGEgZmxhc2ggZGV2aWNlIHRvIG1lLg0KPiA+Pj4+DQo+ID4+
Pj4gICAgTW9yZSBsaWtlIGEgbXVsdGktcHJvdG9jb2wgZmxhc2ggY29udHJvbGxlciwgd2l0aCB0
aGUgcmVhbCBmbGFzaCANCg0KPiA+Pj4+IGNoaXAgY29ubmVjdGVkIHRvIGl0Lg0KPiA+Pj4NCj4g
Pj4+IFJpZ2h0LCB0aGlzIGhhcyBiZWVuIG15IHBvaW50IGZyb20gdGhlIHN0YXJ0Lg0KPiA+Pj4N
Cj4gPj4+IEl0J3MgYSBmbGFzaCBjb250cm9sbGVyLiAgU3VyZSwgeW91IGNhbiBhY2Nlc3MgaXQg
aW4gZGlmZmVyZW50IHdheXMsDQo+IA0KPiAgICBObywgdGhlIHNvZnR3YXJlIGFjY2VzcyB3aWxs
IGJlIHRoZSBzYW1lLCBqdXN0IHRoZSBpbml0aWFsIGNvbnRyb2xlcg0KPiBzZXR1cCB3aWxsIGJl
IHNvbWV3aGF0IGRpZmZlcmVudCBkZXBlbmRpbmcgb24gdGhlIGZsYXNoIHR5cGUgdXNlZC4uLg0K
PiANCj4gPj4+IGJ1dCBpdCdzIHN0aWxsICpqdXN0KiBhIGZsYXNoIGNvbnRyb2xsZXIgYW5kIHRo
dXMgbm90IGEgdHJ1ZSBNRkQuDQo+IA0KPiAgICBBbHNvIGEgU1BJIGNvbnRyb2xsZXIgd2hlbiBh
IFNQSSBidXMgaXMgdXNlZC4NCg0KDQpDeXByZXNzIGhhcyBhbm5vdW5jZWQgdGhlIGluY2x1c2lv
biBvZiBDeXByZXNz4oCZIGhpZ2gtYmFuZHdpZHRoIA0KSHlwZXJCdXPihKIgOC1iaXQgc2VyaWFs
IG1lbW9yeSBpbnRlcmZhY2UgaW50byB0aGUgbmV3IGVYcGFuZGVkIFNQSSAoeFNQSSkgDQplbGVj
dHJpY2FsIGludGVyZmFjZSBzdGFuZGFyZCBmcm9tIHRoZSBKRURFQyBTb2xpZCBTdGF0ZSBUZWNo
bm9sb2d5IA0KQXNzb2NpYXRpb24gDQoNCmZvciBkZXRhaWwsIHBsZWFzZSBnb2VzIHRvDQpodHRw
czovL3d3dy5jeXByZXNzLmNvbS9uZXdzL2N5cHJlc3MtaHlwZXJidXMtbWVtb3J5LWludGVyZmFj
ZS1pbnN0YW50LWFwcGxpY2F0aW9ucy1pbmNvcnBvcmF0ZWQtamVkZWMteHNwaS1lbGVjdHJpY2Fs
IA0KDQoNCkFzIG1lbnRpb25lZCBiZWZvcmUgdGhhdCBIeXBlckZsYXNoIGlzIGEga2luZCBvZiBz
dGFuZGFyZCBOT1IgRmxhc2ggd2l0aCANCmhpZ2gtc3BlZWQgU1BJIGludGVyZmFjZS4NCg0KdGhh
bmtzICYgYmVzdCByZWdhcmRzLA0KTWFzb24NCg0KQ09ORklERU5USUFMSVRZIE5PVEU6DQoNClRo
aXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGlu
Zm9ybWF0aW9uIA0KYW5kL29yIHBlcnNvbmFsIGRhdGEsIHdoaWNoIGlzIHByb3RlY3RlZCBieSBh
cHBsaWNhYmxlIGxhd3MuIFBsZWFzZSBiZSANCnJlbWluZGVkIHRoYXQgZHVwbGljYXRpb24sIGRp
c2Nsb3N1cmUsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRoaXMgZS1tYWlsIA0KKGFuZC9vciBp
dHMgYXR0YWNobWVudHMpIG9yIGFueSBwYXJ0IHRoZXJlb2YgaXMgcHJvaGliaXRlZC4gSWYgeW91
IHJlY2VpdmUgDQp0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB1cyBpbW1lZGlh
dGVseSBhbmQgZGVsZXRlIHRoaXMgbWFpbCBhcyANCndlbGwgYXMgaXRzIGF0dGFjaG1lbnQocykg
ZnJvbSB5b3VyIHN5c3RlbS4gSW4gYWRkaXRpb24sIHBsZWFzZSBiZSANCmluZm9ybWVkIHRoYXQg
Y29sbGVjdGlvbiwgcHJvY2Vzc2luZywgYW5kL29yIHVzZSBvZiBwZXJzb25hbCBkYXRhIGlzIA0K
cHJvaGliaXRlZCB1bmxlc3MgZXhwcmVzc2x5IHBlcm1pdHRlZCBieSBwZXJzb25hbCBkYXRhIHBy
b3RlY3Rpb24gbGF3cy4gDQpUaGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uIGFuZCBjb29wZXJh
dGlvbi4NCg0KTWFjcm9uaXggSW50ZXJuYXRpb25hbCBDby4sIEx0ZC4NCg0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQoNCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCkNPTkZJREVOVElBTElUWSBOT1RFOg0KDQpU
aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBp
bmZvcm1hdGlvbiBhbmQvb3IgcGVyc29uYWwgZGF0YSwgd2hpY2ggaXMgcHJvdGVjdGVkIGJ5IGFw
cGxpY2FibGUgbGF3cy4gUGxlYXNlIGJlIHJlbWluZGVkIHRoYXQgZHVwbGljYXRpb24sIGRpc2Ns
b3N1cmUsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRoaXMgZS1tYWlsIChhbmQvb3IgaXRzIGF0
dGFjaG1lbnRzKSBvciBhbnkgcGFydCB0aGVyZW9mIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNl
aXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHVzIGltbWVkaWF0ZWx5IGFu
ZCBkZWxldGUgdGhpcyBtYWlsIGFzIHdlbGwgYXMgaXRzIGF0dGFjaG1lbnQocykgZnJvbSB5b3Vy
IHN5c3RlbS4gSW4gYWRkaXRpb24sIHBsZWFzZSBiZSBpbmZvcm1lZCB0aGF0IGNvbGxlY3Rpb24s
IHByb2Nlc3NpbmcsIGFuZC9vciB1c2Ugb2YgcGVyc29uYWwgZGF0YSBpcyBwcm9oaWJpdGVkIHVu
bGVzcyBleHByZXNzbHkgcGVybWl0dGVkIGJ5IHBlcnNvbmFsIGRhdGEgcHJvdGVjdGlvbiBsYXdz
LiBUaGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uIGFuZCBjb29wZXJhdGlvbi4NCg0KTWFjcm9u
aXggSW50ZXJuYXRpb25hbCBDby4sIEx0ZC4NCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

