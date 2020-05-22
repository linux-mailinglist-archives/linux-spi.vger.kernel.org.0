Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D484C1DE13B
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgEVHqJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 03:46:09 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:41942 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728230AbgEVHqI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 03:46:08 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Fri, 22 May 2020 15:45:58
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Fri, 22 May 2020 15:45:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Kangjie Lu" <kjlu@umn.edu>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on
 error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5a8a6e7b.bef25.1723b588c7f.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHkD42g8dem0b+AQ--.40491W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgAIBlZdtOQZ8wAAs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbXvS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r4j6F4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r4xMIAIbVCY0x0Ix7I2Y4AK64vIr41lV2
        xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCa
        FVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67
        AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw2
        0EY4v20xvaj40_Wr1j6rW3Jr1lV2xY6IIF0xvEx4A2jsIE14v26r4j6F4UMIAIbVCI42IY
        6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUU==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgQW5keSwKClRoYW5rIHlvdSBmb3IgeW91ciBhZHZpY2UhCgpZb3VyIHN1Z2dlc3Rpb24gaXMg
dG8gdXNlIHBtX3J1bnRpbWVfcHV0X25vaWRsZSgpLCByaWdodD8gClRoZSBvbmx5IGRpZmZlcmVu
Y2UgYmV0d2VlbiBwbV9ydW50aW1lX3B1dCgpIGFuZCB0aGlzIGZ1bmN0aW9uCmlzIHRoYXQgcG1f
cnVudGltZV9wdXQoKSB3aWxsIHJ1biBhbiBleHRyYSBwbV9yZXF1ZXN0X2lkbGUoKS4KIApJIGNo
ZWNrZWQgdGhpcyBwYXRjaGVkIGZ1bmN0aW9uIGFnYWluIGFuZCBmb3VuZCB0aGVyZSBpcyBhCnBt
X3J1bnRpbWVfcHV0KCkgaW4gdGhlIG5vcm1hbCBicmFuY2ggb2YgcG1fcnVudGltZV9nZXRfc3lu
YygpLgpEb2VzIHRoaXMgbWVhbiB0aGUgb3JpZ2luYWwgcHJvZ3JhbSBsb2dpYyBuZWVkIHRvIGV4
ZWN1dGUgaWRsZQpjYWxsYmFjaz8KCkFjY29yZGluZyB0byBydW50aW1lIFBNJ3MgZG9jLCB0aGUg
cG1fcnVudGltZV9nZXRfc3luYygpIGNhbGwKcGFpcmVkIHdpdGggYSBwbV9ydW50aW1lX3B1dCgp
IGNhbGwgd2lsbCBiZSBhcHByb3ByaWF0ZSB0byBlbnN1cmUKdGhhdCB0aGUgZGV2aWNlIGlzIG5v
dCBwdXQgYmFjayB0byBzbGVlcCBkdXJpbmcgdGhlIHByb2JlLiBUaGVyZWZvcmUKSSB0aGluayBw
bV9ydW50aW1lX3B1dCgpIGlzIG1vcmUgYXBwcm9wcmlhdGUgaGVyZS4gRG8geW91IGhhdmUgCm1v
cmUgZGV0YWlsZWQgc3VnZ2VzdGlvbiBmb3Igd2h5IHdlIHNob3VsZCB1c2UgX3B1dF9ub2lkbGUo
KT8KClJlZ2FyZHMsCkRpbmdoYW8gCj4gT24gVGh1LCBNYXkgMjEsIDIwMjAgYXQgMTA6NTAgQU0g
RGluZ2hhbyBMaXUgPGRpbmdoYW8ubGl1QHpqdS5lZHUuY24+IHdyb3RlOgo+ID4KPiA+IHBtX3J1
bnRpbWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIg
ZXZlbgo+ID4gd2hlbiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUuIFRodXMgYSBwYWlyaW5nIGRl
Y3JlbWVudCBpcyBuZWVkZWQgb24KPiA+IHRoZSBlcnJvciBoYW5kbGluZyBwYXRoIHRvIGtlZXAg
dGhlIGNvdW50ZXIgYmFsYW5jZWQuCj4gCj4gLi4uCj4gCj4gPiAgICAgICAgIHJldCA9IHBtX3J1
bnRpbWVfZ2V0X3N5bmMoJnBkZXYtPmRldik7Cj4gPiAgICAgICAgIGlmIChyZXQgPCAwKSB7Cj4g
PiAgICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAicG0gcnVudGltZSBnZXQgZmFp
bGVkLCBlID0gJWRcbiIsIHJldCk7Cj4gCj4gPiArICAgICAgICAgICAgICAgcG1fcnVudGltZV9w
dXQoJnBkZXYtPmRldik7Cj4gCj4gRm9yIGFsbCB5b3VyIHBhdGNoZXMsIHBsZWFzZSwgZG91Ymxl
IGNoZWNrIHdoYXQgeW91IGFyZSBwcm9wb3NpbmcuCj4gCj4gSGVyZSwgSSBiZWxpZXZlLCB0aGUg
Y29ycmVjdCBvbmUgd2lsbCBiZSBfcHV0X25vaWRsZSgpLgo+IAo+IEFGQUlVIHlvdSBhcmUgbm90
IHN1cHBvc2VkIHRvIGFjdHVhbGx5IHN1c3BlbmQgdGhlIGRldmljZSBpbiBjYXNlIG9mIGVycm9y
Lgo+IEJ1dCBJIG1pZ2h0IGJlIG1pc3Rha2VuLCB0aHVzIHNlZSBhYm92ZS4KPiAKPiA+ICAgICAg
ICAgICAgICAgICBnb3RvIGV4aXRfcG1fZGlzYWJsZTsKPiA+ICAgICAgICAgfQo+IAo+IC0tIAo+
IFdpdGggQmVzdCBSZWdhcmRzLAo+IEFuZHkgU2hldmNoZW5rbwo=
