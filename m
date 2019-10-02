Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC9C46D4
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2019 07:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfJBFIE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Oct 2019 01:08:04 -0400
Received: from mout.web.de ([212.227.15.14]:41291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfJBFID (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Oct 2019 01:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569992872;
        bh=kEfl/Iv1CCzaybc5hroeM7fCim74t5N0mvhbCmJZhh4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lov1/5+ayi7kQPFuWY5cE4KjQ8MhpzX1DZikCVg6PiUhB8EQRpDbMDEYwL2PkVSoW
         Jh5bI6niJk3MoViRPvArofzgj69NVOf2ntz9NuZDEEBzwH7vMpprJoPiNnO8t+HiHP
         iTQqgBpKYHtM+Cs+a6ZaQoEKefQsYfVdVURMBoGc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.73.205]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M95ET-1iPgOr0vcL-00CPyu; Wed, 02
 Oct 2019 07:07:52 +0200
Subject: Re: [v2] spi: gpio: prevent memory leak in spi_gpio_probe
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20190930205241.5483-1-navid.emamdoost@gmail.com>
 <6b55e753-5797-2bdc-fae6-f575a0ef8186@web.de>
 <CAEkB2ES3-gotqS9184izf0fKOigFaFUetBiqekmYJPBgPWbSBQ@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <2a5f9775-6cff-4246-435f-9908bfe5b07b@web.de>
Date:   Wed, 2 Oct 2019 07:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAEkB2ES3-gotqS9184izf0fKOigFaFUetBiqekmYJPBgPWbSBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:EepWscPPqkjTYuRxcpWY7vKWJ9nzH5HBEwCxViXdbhWrtPO1p4A
 Uge/5TWXgiuusXVMduOojmqfGkfOFUWioiXpQHpbl4ws/sA4nxMaFx1gMVkM4llUAESg9qp
 +wgunckd94u8xSliNvlxr2zx1UPMA8jMyvdCph4mUlbM7JmzsbpQXV+mEQ0RR2l6EDC/Zkd
 SN4fMV6kBO6O5Vyrb8X6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:75gnEgzxpmY=:H2apDDInJJ8KscY6JK6aWY
 G4BjTe81GQb6HTySg+/2SYQ6h4pfJE3K/KmQviAmJyn6avUw+uRS1xEv+G4T+7IB3dk7QPhwC
 FPJcxAppq/tBrwXZ6Ij0o9w5+Qy4saEykcchlMRi28HfKNiNmdVlEdCc0CB8MlIxHmiy6+LtR
 bfWUFTSuPMYTrcuOrE0Zg7bv653VFOWaE2OifTz7h1BhGr3Tp3bXOx+TLPzXF8T0sYX0+oUPA
 iiu6VGEbkhdj3t0qqMAxDXoVSJClcZIzuiTBtixdcuU0KFcfvuCQjH0ElIrhb3Lu2TOme+RoX
 sqqMdVYU2bti/GzzmDsFPzQe1Y609ArYxRiySxcueXj9pLDwj09MEXE0QGykmIFCo//FF8c38
 ztdfB62plPZ8ubbGGvpKcLiXFCS46KA7xSKjSd1IGs9oXuQYhPFmCYrNWyqJhEMXmapTYVGmk
 848sez2u0H4OGh4gQ3N06uR8s6Vcr+B8onrcFPkPJe4BrfGRUq+p53+h9/Sqk97KRoW7chv1M
 +dIyg0b1Nqz5LNn7SA+STNgQXi1WApFEAxQxGNStUXMpBzR8gztDKfW4mNLfwcG/LWchEBiGX
 Kp1NQWuorLt+b48HbFoXHNYGJcXB8eQkpXizbsZ/dMMo1+nSCWtrZJ8tiFYy0EcG5NYpYWPtz
 XRS+a+ih1/ZHomZjhy8ZQirMA0uOqBPtysv/CHEg+qKBtxDoFuOqcMj5hGCtOk7Lgra9C0r/8
 ECtldX53Ya+qM1cc/hfJps9GRBdaJHslfrf94oSH0yEVcLbWdiWwy/foPhs7PGG7SzRyJV12W
 OhXV70FE/vXE7HNdFWZ2cEpj6Ga9mXEWAjn39Vskzx8RTzrgZPJkQLwXrREacbySfW1xAyTfc
 J6Ir14a46uIG2cO+BxbYDJqPgJcvu5mRzbNSSjEmmPHJVznuUMOYB/sbm0jdh7ZClTFua74ON
 yxKxhnaoSEuprQRn7boSRsx0VEkWcoRVbHKa92OvExCZikosecJQinHOi5KKn8hJ6q9xq2urO
 m1ctYsyM8y2GV/SS3BmJP0fOhvffRoeFlfHnxfvFetD3zxMfGeq97jUadErNara+HZ4CCyS8r
 todNU+Wep3/fkME9lap6/pj0KDRkoVMFGUw8wkvzIntZA6b+gInrhPCfy/qvTpZifrW+RzO7O
 y2gHZ4FeBzCHCsMzBwD+ne8OIG8LVMH4uoxWrCcLFo/OWoHFzK/YE7QC2z557fIoe4Edkw3ZZ
 dd7bnuQsyZOEgHe8sEapnS8zWfJRHZZAUsL+5tlYfG0VgUCuNTle2pgZHxgE=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Hi Markus, thanks for your suggestions for improving the quality of
> the patch. At the moment I prefer first get a confirmation from
> contributors about the leak and then work on any possible improvements
> for the patch.

Please fix this patch as soon as possible if you care for the correctness
of the provided information.

Regards,
Markus
