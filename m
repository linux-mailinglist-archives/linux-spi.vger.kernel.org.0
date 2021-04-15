Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51476360195
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 07:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhDOF2O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 01:28:14 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:52166 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229503AbhDOF2M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 01:28:12 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Thu, 15 Apr 2021 13:27:22
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.8]
Date:   Thu, 15 Apr 2021 13:27:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     wqyoung <quanyang.wang@windriver.com>
Cc:     kjlu@umn.edu, "Mark Brown" <broonie@kernel.org>,
        "Michal Simek" <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] spi: spi-zynqmp-gqspi: Fix runtime PM
 imbalance in zynqmp_qspi_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <20210415012158.GA2465158@pek-qwang2-d1>
References: <20210412073154.25011-1-dinghao.liu@zju.edu.cn>
 <20210415012158.GA2465158@pek-qwang2-d1>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7b720ae6.58927.178d3ff88f3.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3nz66zndgCbQmAQ--.40483W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwNBlZdtTXCvwAIs7
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiBIaSBEaW5naGFvLAo+IE9uIE1vbiwgQXByIDEyLCAyMDIxIGF0IDAzOjMxOjU0UE0gKzA4MDAs
IERpbmdoYW8gTGl1IHdyb3RlOgo+ID4gVGhlcmUgaXMgYSBQTSB1c2FnZSBjb3VudGVyIGRlY3Jl
bWVudCBhZnRlciB6eW5xbXBfcXNwaV9pbml0X2h3KCkKPiA+IHdpdGhvdXQgYW55IHJlZmNvdW50
IGluY3JlbWVudCwgd2hpY2ggbGVhZHMgdG8gcmVmY291bnQgbGVhay5BZGQKPiA+IGEgcmVmY291
bnQgaW5jcmVtZW50IHRvIGJhbGFuY2UgdGhlIHJlZmNvdW50LiBBbHNvIHNldAo+ID4gYXV0b19y
dW50aW1lX3BtIHRvIHJlc3VtZSBzdXNwZW5kZWQgc3BpIGNvbnRyb2xsZXIuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPgo+ID4gLS0t
Cj4gPiBjaGFuZ2Vsb2c6Cj4gPiAKPiA+IHYyOiAtIEFkZCBhIHJlZmNvdW50IGluY3JlbWVudCB0
byBmaXggcmVmY291dCBsZWFrIGluc3RlYWQgb2YgdGhlCj4gPiAgICAgICByZWZjb3VudCBkZWNy
ZW1lbnQgb24gZXJyb3IuCj4gPiAgICAgICBTZXQgY3Rsci0+YXV0b19ydW50aW1lX3BtID0gdHJ1
ZS4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvc3BpL3NwaS16eW5xbXAtZ3FzcGkuYyB8IDIgKysKPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3NwaS9zcGktenlucW1wLWdxc3BpLmMgYi9kcml2ZXJzL3NwaS9zcGktenlucW1wLWdx
c3BpLmMKPiA+IGluZGV4IGM4ZmE2ZWUxOGFlNy4uOGIyMWM3YjBlN2ViIDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9zcGkvc3BpLXp5bnFtcC1ncXNwaS5jCj4gPiArKysgYi9kcml2ZXJzL3NwaS9z
cGktenlucW1wLWdxc3BpLmMKPiA+IEBAIC0xMTYwLDYgKzExNjAsNyBAQCBzdGF0aWMgaW50IHp5
bnFtcF9xc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAgCXBtX3J1
bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZwZGV2LT5kZXYsIFNQSV9BVVRPU1VTUEVORF9U
SU1FT1VUKTsKPiA+ICAJcG1fcnVudGltZV9zZXRfYWN0aXZlKCZwZGV2LT5kZXYpOwo+ID4gIAlw
bV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsKPiA+ICsJcG1fcnVudGltZV9nZXRfc3luYygm
cGRldi0+ZGV2KTsKPiBQbGVhc2UgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBoZXJlLCBpZiByZXQg
aXMgIjwgMCIsIGdvdG8gZXJyb3IgbGFiZWwsCj4gYW5kIGEgcG1fcnVudGltZV9wdXRfc3luYyBp
cyBuZWVkZWQgaW4gZXJyb3IgbGFiZWwKPiA+ICAJLyogUVNQSSBjb250cm9sbGVyIGluaXRpYWxp
emF0aW9ucyAqLwo+ID4gIAl6eW5xbXBfcXNwaV9pbml0X2h3KHhxc3BpKTsKPiA+ICAKPiA+IEBA
IC0xMTg3LDYgKzExODgsNyBAQCBzdGF0aWMgaW50IHp5bnFtcF9xc3BpX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAgCWN0bHItPm1vZGVfYml0cyA9IFNQSV9DUE9MIHwg
U1BJX0NQSEEgfCBTUElfUlhfRFVBTCB8IFNQSV9SWF9RVUFEIHwKPiA+ICAJCQkgICAgU1BJX1RY
X0RVQUwgfCBTUElfVFhfUVVBRDsKPiA+ICAJY3Rsci0+ZGV2Lm9mX25vZGUgPSBucDsKPiA+ICsJ
Y3Rsci0+YXV0b19ydW50aW1lX3BtID0gdHJ1ZTsKPiA+ICAKPiA+ICAJcmV0ID0gZGV2bV9zcGlf
cmVnaXN0ZXJfY29udHJvbGxlcigmcGRldi0+ZGV2LCBjdGxyKTsKPiA+ICAJaWYgKHJldCkgewo+
IFRoZXNlIDIgZnVuY3Rpb24KPiAgICAgIHBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koJnBkZXYt
PmRldik7Cj4gICAgICAgcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoJnBkZXYtPmRldik7Cj4g
YXJlIHRoZSBsYXN0IG9wZXJhdGlvbnMgaW4gcHJvYmUgZnVuY3Rpb24gc2luY2UgaWYgdGhleSBy
dW5zLAo+IHNwaV9jb250cm9sbGVyIHdpbGwgZW50ZXIgc3VzcGVuZCBzdGF0ZSBhbmQgZGlzYWJs
ZSBjbGtzIGFmdGVyIDNzCj4gcGFzc2luZy4gU28gcGxlYXNlIG1vdmUgdGhlbSBqdXN0IGJlZm9y
ZSAicmV0dXJuIDAiLgo+IAo+IEFuZCB3b3VsZCB5b3UgcGxlYXNlIGNjIG1lIHdoZW4geW91IHNl
bmQgVjM/IEkgYW0gcHJlcGFyaW5nIHRvIHNlbmQgYSBwYXRjaCBzZXJpZXMKPiB0byBmaXggY2xr
IGFuZCBzdXNwZW5kL3Jlc3VtZSBpc3N1ZXMgd2hpY2ggYmFzZXMgb24gdGhlIHBtX3J1bnRpbWUg
aXNzdWUuCj4gCgpUaGFua3MgZm9yIHlvdXIgYWR2aWNlIGFuZCBJIHdpbGwgc2VuZCBhIG5ldyBw
YXRjaCBzb29uLgoKUmVnYXJkcywKRGluZ2hhbw==
