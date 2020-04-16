Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC741ABCF4
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503898AbgDPJgc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 05:36:32 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:44108 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503955AbgDPJga (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 05:36:30 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        by skedge04.snt-world.com (Postfix) with ESMTP id F292267A88C;
        Thu, 16 Apr 2020 11:36:20 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Apr
 2020 11:36:20 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 16 Apr 2020 11:36:20 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Ashish Kumar <Ashish.Kumar@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times
 AHB buffer size
Thread-Topic: [PATCH] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times
 AHB buffer size
Thread-Index: AQHWE8nPWwzel+dHH0GqZo96UrGKSqh7W90A
Date:   Thu, 16 Apr 2020 09:36:20 +0000
Message-ID: <95c90219-0fd9-c0b4-5c1a-6abb321ef2e3@kontron.de>
References: <1587025984-5696-1-git-send-email-Ashish.Kumar@nxp.com>
In-Reply-To: <1587025984-5696-1-git-send-email-Ashish.Kumar@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <409EE66D3830CE4B8F8730C222B272BF@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: F292267A88C.ADFEE
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: ashish.kumar@nxp.com, boris.brezillon@collabora.com,
        broonie@kernel.org, kuldeep.singh@nxp.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
X-Spam-Status: No
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgQXNoaXNoLA0KDQpPbiAxNi4wNC4yMCAxMDozMywgQXNoaXNoIEt1bWFyIHdyb3RlOg0KPiBS
ZWR1Y2UgZGV2bV9pb3JlbWFwIHNpemUgdG8gKDQgKiBBSEJfQlVGRVJfU0laRSkgcmF0aGVyIHRo
YW4gbWFwcGluZw0KPiBjb21wbGV0ZSBRU1BJLU1lbW1vcnkgYXMgZHJpdmVyIGlzIG5vdyBpbmRl
cGVuZGVudCBvZiBmbGFzaCBzaXplLg0KPiBGbGFzaCBvZiBhbnkgc2l6ZSBjYW4gYmUgYWNjZXNz
ZWQuDQo+IA0KPiBJc3N1ZSB3YXMgcmVwb3J0ZWQgb24gcGxhdGZvcm0gd2hlcmUgZGV2bV9pb3Jl
bWFwIGZhaWx1cmUgaXMgb2JzZXJ2ZWQNCj4gd2l0aCBzaXplID4gMjU2TS4NCj4gRXJyb3IgbG9n
IG9uIExTMTAyMUFUV1IgOg0KPiAgIGZzbC1xdWFkc3BpIDE1NTAwMDAuc3BpOiBpb3JlbWFwIGZh
aWxlZCBmb3IgcmVzb3VyY2UgW21lbSAweDQwMDAwMDAwLTB4N2ZmZmZmZmZdDQo+ICAgZnNsLXF1
YWRzcGkgMTU1MDAwMC5zcGk6IEZyZWVzY2FsZSBRdWFkU1BJIHByb2JlIGZhaWxlZA0KPiAgIGZz
bC1xdWFkc3BpOiBwcm9iZSBvZiAxNTUwMDAwLnNwaSBmYWlsZWQgd2l0aCBlcnJvciAtMTINCj4g
DQo+IFRoaXMgY2hhbmdlIHdhcyBhbHNvIHN1Z2dlc3RlZCBwcmV2aW91c2x5Og0KPiBodHRwczov
L2V1cjA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZwYXRjaHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTA1MDg3NTMlMkYlMjMyMjE2NjM4NSZh
bXA7ZGF0YT0wMiU3QzAxJTdDZnJpZWRlci5zY2hyZW1wZiU0MGtvbnRyb24uZGUlN0NiYTI2ODE3
ZTc1OWI0NjA4MTlhNzA4ZDdlMWUwZDA4MyU3QzhjOWQzYzk3M2ZkOTQxYzhhMmIxNjQ2ZjM5NDJk
YWYxJTdDMCU3QzAlN0M2MzcyMjYyMjg1NDMxMzIyNzImYW1wO3NkYXRhPXo3d2VrRFRnJTJGTjdD
WlV5N2lrTSUyQlZIT0tUOTVZYkRKMGNyMkpFNjJXZ3p3JTNEJmFtcDtyZXNlcnZlZD0wDQoNClNv
IGlmIHlvdSB3YW50IHlvdSBjb3VsZCBhZGQgYSAiU3VnZ2VzdGVkLWJ5IiB0YWcgcmVmZXJyaW5n
IHRvIEJvcmlzLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLdWxkZWVwIFNpbmdoIDxrdWxkZWVw
LnNpbmdoQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFzaGlzaCBLdW1hciA8QXNoaXNoLmt1
bWFyQG54cC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvc3BpL3NwaS1mc2wtcXNwaS5jIHwgMTAg
KysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMgYi9k
cml2ZXJzL3NwaS9zcGktZnNsLXFzcGkuYw0KPiBpbmRleCA2M2M5ZjdlLi5hNDFjZTgxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktZnNsLXFzcGkuYw0KPiArKysgYi9kcml2ZXJzL3Nw
aS9zcGktZnNsLXFzcGkuYw0KPiBAQCAtODU5LDE0ICs4NTksMTUgQEAgc3RhdGljIGludCBmc2xf
cXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIA0KPiAgIAlyZXMg
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLA0KPiAg
IAkJCQkJIlF1YWRTUEktbWVtb3J5Iik7DQo+IC0JcS0+YWhiX2FkZHIgPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCByZXMpOw0KPiArCXEtPm1lbW1hcF9waHkgPSByZXMtPnN0YXJ0Ow0KPiAr
CS8qIFNpbmNlIHRoZXJlIGFyZSA0IENTIG1heCBNQVAgcmVxdWlyZWQgaXMgNCB0aW1lIGFoYl9i
dWZfc2l6ZSAqLw0KDQovKiBTaW5jZSB0aGVyZSBhcmUgNCBjcywgbWFwIHNpemUgcmVxdWlyZWQg
aXMgNCB0aW1lcyBhaGJfYnVmX3NpemUgKi8NCg0KPiArCXEtPmFoYl9hZGRyID0gZGV2bV9pb3Jl
bWFwKGRldiwgcS0+bWVtbWFwX3BoeSwNCj4gKwkJCQkgICAocS0+ZGV2dHlwZV9kYXRhLT5haGJf
YnVmX3NpemUgKiA0KSk7DQo+ICAgCWlmIChJU19FUlIocS0+YWhiX2FkZHIpKSB7DQo+ICAgCQly
ZXQgPSBQVFJfRVJSKHEtPmFoYl9hZGRyKTsNCj4gICAJCWdvdG8gZXJyX3B1dF9jdHJsOw0KPiAg
IAl9DQo+ICAgDQo+IC0JcS0+bWVtbWFwX3BoeSA9IHJlcy0+c3RhcnQ7DQo+IC0NCj4gICAJLyog
ZmluZCB0aGUgY2xvY2tzICovDQo+ICAgCXEtPmNsa19lbiA9IGRldm1fY2xrX2dldChkZXYsICJx
c3BpX2VuIik7DQo+ICAgCWlmIChJU19FUlIocS0+Y2xrX2VuKSkgew0KPiBAQCAtOTM5LDYgKzk0
MCw5IEBAIHN0YXRpYyBpbnQgZnNsX3FzcGlfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAgDQo+ICAgCW11dGV4X2Rlc3Ryb3koJnEtPmxvY2spOw0KPiAgIA0KPiArCWlm
IChxLT5haGJfYWRkcikNCj4gKwkJZGV2bV9pb3VubWFwKHEtPmRldiwgcS0+YWhiX2FkZHIpOw0K
DQpZb3UgZG9uJ3QgbmVlZCB0byB1bm1hcCBleHBsaWNpdGx5LiBVc2luZyBkZXZtXyooKSwgbGlm
ZXRpbWUgb2YgdGhlIA0KcmVzb3VyY2UgaXMgYWxyZWFkeSB0aWVkIHRvIHRoZSBkZXZpY2UuDQoN
ClRoYW5rcywNCkZyaWVkZXINCg0KPiArDQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4g
