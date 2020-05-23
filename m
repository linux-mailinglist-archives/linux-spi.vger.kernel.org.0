Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E351DF713
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgEWMEn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 May 2020 08:04:43 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:22260 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387811AbgEWMEl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 23 May 2020 08:04:41 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sat, 23 May 2020 20:04:29
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Sat, 23 May 2020 20:04:29 +0800 (GMT+08:00)
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
Subject: Re: Re: Re: Re: [PATCH] spi: tegra20-slink: Fix runtime PM
 imbalance on error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAHp75VcfcE63KHbyokoBuBKDdTHiB8QiauL8XU=rRo0-=NL-Kg@mail.gmail.com>
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
 <5a8a6e7b.bef25.1723b588c7f.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75Vem1kQviLrobJ65aVOb_VCmLkAv=5U_iXAdWPNe7n0+Ng@mail.gmail.com>
 <CAHp75VexCBc6iCrd_VLj5jXE8cxxdzUUf6pMG6O8LjtNj0J1Aw@mail.gmail.com>
 <53722a45.c204d.172414e8ed8.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75VcfcE63KHbyokoBuBKDdTHiB8QiauL8XU=rRo0-=NL-Kg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <ee08a95.c20fb.172416b96e4.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgDn7z9NEclek5USAg--.44992W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEJBlZdtORShQAAsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbXvS07vEb7Iv0x
        C_Xr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_JrI_JrylV2xY6cIj6I8E87Iv67AKxVW8JVWxJwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwVW5JwCS07vEc2IjII80xcxEwVAKI48JMI
        AIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCS07vEIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUU==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiBPbiBTYXQsIE1heSAyMywgMjAyMCBhdCAyOjMyIFBNIDxkaW5naGFvLmxpdUB6anUuZWR1LmNu
PiB3cm90ZToKPiA+Cj4gPiA+IE9uIEZyaSwgTWF5IDIyLCAyMDIwIGF0IDY6MjAgUE0gQW5keSBT
aGV2Y2hlbmtvCj4gPiA+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToKPiA+ID4g
PiBPbiBGcmksIE1heSAyMiwgMjAyMCBhdCAxMDo0NiBBTSA8ZGluZ2hhby5saXVAemp1LmVkdS5j
bj4gd3JvdGU6Cj4gCj4gLi4uCj4gCj4gPiBJIGFsc28gY2hlY2tlZCBtYW55IG90aGVyIGltcGxl
bWVudGF0aW9uIG9mIHByb2JlIGluIGRyaXZlcnMuCj4gPiBJdCBzZWVtcyB0aGF0IHVzaW5nIHBt
X3J1bnRpbWVfcHV0KCkgaXMgb2suCj4gCj4gSW4gKmVycm9yIHBhdGgqIG9yIG5vcm1hbCBwYXRo
Pwo+IAoKRXJyb3IgcGF0aCAoZS5nLiwgc3lzY19wcm9iZSwgZXh5bm9zX3RybmdfcHJvYmUsIApt
YXBfcm5nX3Byb2JlLCB0aV9lcWVwX3Byb2JlKS4KCj4gPiBJZiBJIG1pc3VuZGVyc3Rvb2QKPiA+
IHlvdXIgb3BpbmlvbiwgcGxlYXNlIHBvaW50IGl0IG91dCwgdGhhbmtzLgo+IAo+IEJvdHRvbSBs
aW5lIGlzIChmb3IgdGhlICplcnJvciBwYXRoKiBjYXNlKToKPiBwbV9ydW50aW1lX3B1dF9ub2lk
bGUoKSBoYXMgbm8gc2lkZSBlZmZlY3RzCj4gcG1fcnVudGltZV9wdXQoKSAocG90ZW50aWFsbHkp
IG1pZ2h0IGhhdmUgc2lkZSBlZmZlY3RzLgo+IAo+IFlvdSBzaG91bGQgY2hvb3NlIG9uZSB3aGlj
aCBpcyBjbGVhcmVyIGFib3V0IHdoYXQgaXQgZG9lcy4KPiAKPiAtLSAKPiBXaXRoIEJlc3QgUmVn
YXJkcywKPiBBbmR5IFNoZXZjaGVua28KCkFncmVlLCBmb3IgdGhpcyBidWcgdXNpbmcgX25vaWRs
ZSgpIGlzIGNsZWFyZXIuIEkgd2lsbCAKc2VuZCBhIG5ldyBwYXRoIHRvIGZpeCB0aGlzLgoKUmVn
YXJkcywKRGluZ2hhbwoK
