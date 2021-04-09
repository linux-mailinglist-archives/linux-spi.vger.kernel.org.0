Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4B3596CC
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 09:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhDIHx7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 03:53:59 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:61502 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229621AbhDIHx6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 03:53:58 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Fri, 9 Apr 2021 15:53:37
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.8]
Date:   Fri, 9 Apr 2021 15:53:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "quanyang.wang" <quanyang.wang@windriver.com>
Cc:     "Michal Simek" <michal.simek@xilinx.com>, kjlu@umn.edu,
        "Amit Kumar Mahapatra" <amit.kumar-mahapatra@xilinx.com>,
        "Mark Brown" <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
 zynqmp_qspi_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <ef4555a6-1674-d9c0-6401-cdf43780a014@windriver.com>
References: <20210408092559.3824-1-dinghao.liu@zju.edu.cn>
 <17b5d33f-ce96-dc07-05f7-41d87f53a3d0@xilinx.com>
 <ef4555a6-1674-d9c0-6401-cdf43780a014@windriver.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2b385fb0.45344.178b59f4790.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgDHsDwBCHBggj7xAA--.29738W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgkKBlZdtTUlDwAAsm
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiBIaSBEaW5naGFvLAo+IAo+IE9uIDQvOC8yMSA2OjMzIFBNLCBNaWNoYWwgU2ltZWsgd3JvdGU6
Cj4gPiArKwo+ID4KPiA+IE9uIDQvOC8yMSAxMToyNSBBTSwgRGluZ2hhbyBMaXUgd3JvdGU6Cj4g
Pj4gV2hlbiBwbGF0Zm9ybV9nZXRfaXJxKCkgZmFpbHMsIGEgcGFpcmluZyBQTSB1c2FnZSBjb3Vu
dGVyCj4gPj4gaW5jcmVtZW50IGlzIG5lZWRlZCB0byBrZWVwIHRoZSBjb3VudGVyIGJhbGFuY2Vk
LiBJdCdzIHRoZQo+ID4+IHNhbWUgZm9yIHRoZSBmb2xsb3dpbmcgZXJyb3IgcGF0aHMuCj4gPj4K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5jbj4K
PiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvc3BpL3NwaS16eW5xbXAtZ3FzcGkuYyB8IDEgKwo+ID4+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zcGkvc3BpLXp5bnFtcC1ncXNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLXp5bnFtcC1n
cXNwaS5jCj4gPj4gaW5kZXggYzhmYTZlZTE4YWU3Li45NTk2M2EyZGU2NGEgMTAwNjQ0Cj4gPj4g
LS0tIGEvZHJpdmVycy9zcGkvc3BpLXp5bnFtcC1ncXNwaS5jCj4gPj4gKysrIGIvZHJpdmVycy9z
cGkvc3BpLXp5bnFtcC1ncXNwaS5jCj4gPj4gQEAgLTExOTcsNiArMTE5Nyw3IEBAIHN0YXRpYyBp
bnQgenlucW1wX3FzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+PiAg
IAlyZXR1cm4gMDsKPiA+PiAgIAo+ID4+ICAgY2xrX2Rpc19hbGw6Cj4gPj4gKwlwbV9ydW50aW1l
X2dldF9ub3Jlc3VtZSgmcGRldi0+ZGV2KTsKPiA+PiAgIAlwbV9ydW50aW1lX3NldF9zdXNwZW5k
ZWQoJnBkZXYtPmRldik7Cj4gPj4gICAJcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOwo+
ID4+ICAgCWNsa19kaXNhYmxlX3VucHJlcGFyZSh4cXNwaS0+cmVmY2xrKTsKPiA+Pgo+IFRoZSBp
bWJhbGFuY2UgaXMgYmVjYXVzZSBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZCBpcyBjYWxsZWQg
dG8gbWFrZSAKPiBjb3VudGVyIHRvIGJlIC0xLgo+IAo+IEl0IGxvb2tzIHN0cmFuZ2UgdGhhdCB0
aGVyZSBpcyBubyBjb3VudGVyIGluY3JlYW1lbnQgb3AgYmVmb3JlIAo+IHBtX3J1bnRpbWVfcHV0
X2F1dG9zdXNwZW5kLgo+IAo+IEluIG15IGxpbWl0ZWQgdW5kZXJzdGFuZGluZywgaXQgc2hvdWxk
IGxvb2sgbGlrZToKPiAKPiAuLi4uLi4KPiAKPiBwbV9ydW50aW1lX2VuYWJsZQo+IAo+IHBtX3J1
bnRpbWVfZ2V0X3N5bmMgwqAgLy9pbmNyZWFzZSBjb3VudGVyIHRvIG9uZSB0byByZXN1bWUgZGV2
aWNlCj4gCj4gRE8gT1BFUkFUSU9OUyBIRVJFCj4gCj4gcG1fcnVudGltZV9tYXJrX2xhc3RfYnVz
eQo+IHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kIMKgIC8vZGVjcmVhc2UgY291bnRlciB0byB6
ZXJvIGFuZCB0cmlnZ2VyIHN1c3BlbmQKPiAKPiByZXR1cm4gMDsKPiAKPiBlcnJvcl9wYXRoOgo+
IAo+IHBtX3J1bnRpbWVfcHV0X3N5bmMKPiAKPiBwbV9ydW50aW1lX2Rpc2FibGUKPiAKPiByZXR1
cm4gZXJyOwo+IAo+IAo+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4gCgpUaGFua3MgZm9yIHBv
aW50IG91dCB0aGlzISBVc3VhbGx5IHRoZXJlIGlzIGFuIGluY3JlbWVudCByZWZjb3VudCBpbiBh
IApfcHJvYmUgZnVuY3Rpb24gYW5kIGEgZGVjcmVtZW50IHJlZmNvdW50IGluIGEgX3JlbW92ZSBm
dW5jdGlvbi4gU29tZXRpbWVzIAp0aGUgcmVmY291bnQgZGVjcmVtZW50IGlzIGluIHRoZSBfcHJv
YmUgYW5kIHRoZSBpbmNyZW1lbnQgaXMgaW4gdGhlIF9yZW1vdmUuIApCdXQgdGhlIHJlZmNvdW50
IGlzIGJhbGFuY2VkIGluIGJvdGggY2FzZXMuIFNvIEkgdGhpbmsgenlucW1wX3FzcGlfcmVtb3Zl
KCkKbmVlZHMgYSByZWZjb3VudCBpbmNyZW1lbnQgdG8gZml4IHRoaXMgYnVnLgoKUmVnYXJkcywK
RGluZ2hhbw==
