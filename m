Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7D1DC872
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgEUIZH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 04:25:07 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:50406 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728596AbgEUIZH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 04:25:07 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 21 May 2020 16:24:53
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.77.158]
Date:   Thu, 21 May 2020 16:24:53 +0800 (GMT+08:00)
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
In-Reply-To: <CAHp75Vf=a54jY+5ZoWG9Fkjf-0-TQWqNY6R4sPM7Y2oTyCNL6A@mail.gmail.com>
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
 <CAHp75Vf=a54jY+5ZoWG9Fkjf-0-TQWqNY6R4sPM7Y2oTyCNL6A@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <611a62f0.baefa.1723655d227.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgDn7z_VOsZe9wzqAQ--.42098W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEHBlZdtOPItAAZs7
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbXvS07vEb7Iv0x
        C_JF4lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r4j6F4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r43MIAIbVCY0x0Ix7I2Y4AK64vIr41lV2
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

SGkgQW5keSwKClRoYW5rIHlvdSBmb3IgeW91ciBhZHZpY2UhIEkgd2lsbCBmaXggdGhlIHByb2Js
ZW0gaW4gdGhlIG5leHQgZWRpdGlvbgpvZiBwYXRjaC4gVGhlIGNvY2NpbmVsbGUgc2NyaXB0IHdp
bGwgYmUgdmVyeSBoZWxwZnVsIGFuZCBJJ20gbG9va2luZyAKZm9yd2FyZCB0byBpdC4KClJlZ2Fy
ZHMsCkRpbmdoYW8gCgomcXVvdDtBbmR5IFNoZXZjaGVua28mcXVvdDsgJmx0O2FuZHkuc2hldmNo
ZW5rb0BnbWFpbC5jb20mZ3Q75YaZ6YGT77yaCj4gT24gVGh1LCBNYXkgMjEsIDIwMjAgYXQgMTE6
MDQgQU0gQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90
ZToNCj4gPiBPbiBUaHUsIE1heSAyMSwgMjAyMCBhdCAxMDo1MCBBTSBEaW5naGFvIExpdSA8ZGlu
Z2hhby5saXVAemp1LmVkdS5jbj4gd3JvdGU6DQo+IA0KPiBBbnkgSSBoYXZlIGNvY2NpbmVsbGUg
c2NyaXB0IGZvciB0aGlzLCBJIGNhbiBzaGFyZSB3aXRoIHlvdS4NCj4gDQo+IC0tIA0KPiBXaXRo
IEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
