Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922B41AC0AC
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 14:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634902AbgDPMEJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 08:04:09 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:47088 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634884AbgDPMEI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 08:04:08 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        by skedge03.snt-world.com (Postfix) with ESMTP id 532A267A7C0;
        Thu, 16 Apr 2020 14:04:04 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Apr
 2020 14:04:03 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 16 Apr 2020 14:04:03 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Ashish Kumar <Ashish.Kumar@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v3] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times
 AHB buffer size
Thread-Topic: [PATCH v3] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4
 times AHB buffer size
Thread-Index: AQHWE+RA0RHIVaBwxUiIiH6VCp6sU6h7hO6A
Date:   Thu, 16 Apr 2020 12:04:03 +0000
Message-ID: <1e61b277-b690-ed54-95ea-59a976773050@kontron.de>
References: <1587037399-18672-1-git-send-email-Ashish.Kumar@nxp.com>
In-Reply-To: <1587037399-18672-1-git-send-email-Ashish.Kumar@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC63ED8397EC904E8F72C1FE7BB4F27F@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 532A267A7C0.AEBA0
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

T24gMTYuMDQuMjAgMTM6NDMsIEFzaGlzaCBLdW1hciB3cm90ZToNCj4gUmVkdWNlIGRldm1faW9y
ZW1hcCBzaXplIHRvICg0ICogQUhCX0JVRkVSX1NJWkUpIHJhdGhlciB0aGFuIG1hcHBpbmcNCj4g
Y29tcGxldGUgUVNQSS1NZW1tb3J5IGFzIGRyaXZlciBpcyBub3cgaW5kZXBlbmRlbnQgb2YgZmxh
c2ggc2l6ZS4NCj4gRmxhc2ggb2YgYW55IHNpemUgY2FuIGJlIGFjY2Vzc2VkLg0KPiANCj4gSXNz
dWUgd2FzIHJlcG9ydGVkIG9uIHBsYXRmb3JtIHdoZXJlIGRldm1faW9yZW1hcCBmYWlsdXJlIGlz
IG9ic2VydmVkDQo+IHdpdGggc2l6ZSA+IDI1Nk0uDQo+IEVycm9yIGxvZyBvbiBMUzEwMjFBVFdS
IDoNCj4gICBmc2wtcXVhZHNwaSAxNTUwMDAwLnNwaTogaW9yZW1hcCBmYWlsZWQgZm9yIHJlc291
cmNlIFttZW0gMHg0MDAwMDAwMC0weDdmZmZmZmZmXQ0KPiAgIGZzbC1xdWFkc3BpIDE1NTAwMDAu
c3BpOiBGcmVlc2NhbGUgUXVhZFNQSSBwcm9iZSBmYWlsZWQNCj4gICBmc2wtcXVhZHNwaTogcHJv
YmUgb2YgMTU1MDAwMC5zcGkgZmFpbGVkIHdpdGggZXJyb3IgLTEyDQo+IA0KPiBUaGlzIGNoYW5n
ZSB3YXMgYWxzbyBzdWdnZXN0ZWQgcHJldmlvdXNseToNCj4gaHR0cHM6Ly9ldXIwNC5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Y2h3b3JrLmtl
cm5lbC5vcmclMkZwYXRjaCUyRjEwNTA4NzUzJTJGJTIzMjIxNjYzODUmYW1wO2RhdGE9MDIlN0Mw
MSU3Q2ZyaWVkZXIuc2NocmVtcGYlNDBrb250cm9uLmRlJTdDZjJjMjQ1NTkwODg4NDE5ODI3Nzcw
OGQ3ZTFmYjYxNDYlN0M4YzlkM2M5NzNmZDk0MWM4YTJiMTY0NmYzOTQyZGFmMSU3QzAlN0MwJTdD
NjM3MjI2MzQyMDk0Nzc3MDMxJmFtcDtzZGF0YT1RZUFwR2d1cEM0UndmYlNuUUxJWHM0MW83VllL
Szc0N05Dclp6biUyRlJaS1ElM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IFN1Z2dlc3RlZC1ieTog
Qm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogS3VsZGVlcCBTaW5naCA8a3VsZGVlcC5zaW5naEBueHAuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBBc2hpc2ggS3VtYXIgPEFzaGlzaC5rdW1hckBueHAuY29tPg0KDQpSZXZpZXdlZC1i
eTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KDQo+IC0t
LQ0KPiB2MzoNCj4gVXBkYXRlIGNvbW1lbnQNCj4gdjI6DQo+IEFkZCBTdWdnZXN0ZWQtYnk6IEJv
cmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+DQo+IEluY29ycnBv
cmF0ZSByZXZpZXcgY29tbWVudHMgZnJvbSBGcmllZGVyDQo+ICAgZHJpdmVycy9zcGkvc3BpLWZz
bC1xc3BpLmMgfCA3ICsrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1mc2wt
cXNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMNCj4gaW5kZXggNjNjOWY3ZS4uOGI5
NWUyZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMNCj4gKysrIGIv
ZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMNCj4gQEAgLTg1OSwxNCArODU5LDE1IEBAIHN0YXRp
YyBpbnQgZnNsX3FzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAN
Cj4gICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNF
X01FTSwNCj4gICAJCQkJCSJRdWFkU1BJLW1lbW9yeSIpOw0KPiAtCXEtPmFoYl9hZGRyID0gZGV2
bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gKwlxLT5tZW1tYXBfcGh5ID0gcmVzLT5z
dGFydDsNCj4gKwkvKiBTaW5jZSB0aGVyZSBhcmUgNCBjcywgbWFwIHNpemUgcmVxdWlyZWQgaXMg
NCB0aW1lcyBhaGJfYnVmX3NpemUgKi8NCj4gKwlxLT5haGJfYWRkciA9IGRldm1faW9yZW1hcChk
ZXYsIHEtPm1lbW1hcF9waHksDQo+ICsJCQkJICAgKHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9z
aXplICogNCkpOw0KPiAgIAlpZiAoSVNfRVJSKHEtPmFoYl9hZGRyKSkgew0KPiAgIAkJcmV0ID0g
UFRSX0VSUihxLT5haGJfYWRkcik7DQo+ICAgCQlnb3RvIGVycl9wdXRfY3RybDsNCj4gICAJfQ0K
PiAgIA0KPiAtCXEtPm1lbW1hcF9waHkgPSByZXMtPnN0YXJ0Ow0KPiAtDQo+ICAgCS8qIGZpbmQg
dGhlIGNsb2NrcyAqLw0KPiAgIAlxLT5jbGtfZW4gPSBkZXZtX2Nsa19nZXQoZGV2LCAicXNwaV9l
biIpOw0KPiAgIAlpZiAoSVNfRVJSKHEtPmNsa19lbikpIHsNCj4g
