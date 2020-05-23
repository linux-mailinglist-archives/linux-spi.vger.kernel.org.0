Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7E1DF6DC
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgEWLc7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 May 2020 07:32:59 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:20546 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387741AbgEWLc7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 23 May 2020 07:32:59 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sat, 23 May 2020 19:32:46
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Sat, 23 May 2020 19:32:46 +0800 (GMT+08:00)
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
Subject: Re: Re: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on
 error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CAHp75VexCBc6iCrd_VLj5jXE8cxxdzUUf6pMG6O8LjtNj0J1Aw@mail.gmail.com>
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
 <5a8a6e7b.bef25.1723b588c7f.Coremail.dinghao.liu@zju.edu.cn>
 <CAHp75Vem1kQviLrobJ65aVOb_VCmLkAv=5U_iXAdWPNe7n0+Ng@mail.gmail.com>
 <CAHp75VexCBc6iCrd_VLj5jXE8cxxdzUUf6pMG6O8LjtNj0J1Aw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <53722a45.c204d.172414e8ed8.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHf3jeCcle70MSAg--.40478W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgAJBlZdtORRbAABsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbXIS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkIecxEwVAFwVW8KwCS07vEc2IjII80xcxEwVAKI48JMI
        AIbVCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCS07vEx2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlV2xY6I8E67AF67kF1VAFwI0_Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lV2xY6IIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lV2xY6IIF0xvEx4A2jsIE14v26r1j6r4UMIAIbVCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73U
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiBPbiBGcmksIE1heSAyMiwgMjAyMCBhdCA2OjIwIFBNIEFuZHkgU2hldmNoZW5rbwo+IDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToKPiA+IE9uIEZyaSwgTWF5IDIyLCAyMDIwIGF0
IDEwOjQ2IEFNIDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPiB3cm90ZToKPiAKPiAuLi4KPiAKPiA+
IE1vcmVvdmVyLCBjb25zaWRlciBiZWxvdyBjYXNlCj4gPgo+ID4gQ1BVMTogLi4uc29tZXdoZXJl
IGluIHRoZSBjb2RlLi4uCj4gPiBwbV9ydW50aW1lX2dldCgpIC8vIHdpdGggc3VjY2VzcyEKPiA+
IC4uLnNlZSBiZWxvdy4uLgo+ID4gcG1fcnVudGltZV9wdXQoKQo+ID4KPiA+IENQVTI6IC4uLm9u
IHBhcmFsbGVsIHRocmVhZC4uLgo+ID4gcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYygpIC8vIGZh
aWxlZCEKPiA+IGlmIChyZXQpCj4gPiAgIHBtX3J1bnRpbWVfcHV0KCkgLy8gb2kgdmVpLCB3ZSBw
dXQgZGV2aWNlIGludG8gc2xlZXAKPiA+Cj4gPiBTbywgdGhlcmUgaXMgYSBwb3RlbnRpYWwgaXNz
dWUuCj4gCj4gLi4uYW5kIGV2ZW4gaWYgaXQncyBpbXBvc3NpYmxlIChubyBidWdzIGluIHJ1bnRp
bWUgUE0gY29yZSwgZXRjKSB0aGUKPiBjb2RlIHdpdGggcHV0KCkgbG9va3Mgc3VzcGljaW91cy4K
PiAKCkkgbWF5IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIHdvcnJpZWQgYWJvdXQuIERvIHlvdSBt
ZWFuIHRoYXQKZXhlY3V0aW5nIHBtX3J1bnRpbWVfcHV0KCkgd2lsbCBpbmZsdWVuY2Ugb3RoZXIg
dGhyZWFkcyAoZS5nLiwKb25lIHBhcmFsbGVsIHRocmVhZCBjYW4gcHV0IHRoZSBkZXZpY2UgaW50
byBzbGVlcCB3aGlsZSBvdGhlcgp0aHJlYWRzIGFyZSB1c2luZyB0aGlzIGRldmljZSk/CgpJIHRo
aW5rIHRoaXMgd2lsbCBuZXZlciBoYXBwZW4uIEJlY2F1c2UgaW4gdGhpcyBjYXNlIHRoZSBQTSB1
c2FnZQpjb3VudGVyIGNhbm5vdCBiZSBkZWNyZWFzZWQgdG8gemVybyBpZiB0aGVyZSBhcmUgc3Rp
bGwgc29tZSB0aHJlYWRzCnVzaW5nIHRoaXMgZGV2aWNlLiBPdGhlcndpc2UsIHBtX3J1bnRpbWVf
cHV0KCkgc2hvdWxkIG5ldmVyIGJlCnVzZWQgaW4gdGhlIGNhc2Ugb2YgbXVsdGl0aHJlYWRpbmcs
IHdoaWNoIGlzIHN0cmFuZ2Ugc2luY2UgdGhpcwpBUEkgaXMgdXNlZCB3aWRlbHkuIAoKSSBhbHNv
IGNoZWNrZWQgbWFueSBvdGhlciBpbXBsZW1lbnRhdGlvbiBvZiBwcm9iZSBpbiBkcml2ZXJzLgpJ
dCBzZWVtcyB0aGF0IHVzaW5nIHBtX3J1bnRpbWVfcHV0KCkgaXMgb2suIElmIEkgbWlzdW5kZXJz
dG9vZAp5b3VyIG9waW5pb24sIHBsZWFzZSBwb2ludCBpdCBvdXQsIHRoYW5rcy4KClJlZ2FyZHMs
CkRpbmdoYW8KCj4gLS0gCj4gV2l0aCBCZXN0IFJlZ2FyZHMsCj4gQW5keSBTaGV2Y2hlbmtvCg==

