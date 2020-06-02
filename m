Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D31EB7DC
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgFBJFe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 05:05:34 -0400
Received: from mout.web.de ([212.227.15.3]:53807 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgFBJFd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 05:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591088710;
        bh=XhGeAXDfw9AiiSAdvgQbq6rf/vrbHOyi+DVrpim7IVs=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=KhkZSSBzq4cg1+S1MUCxdW3q+ygMyZKelIIs8+nygoTvJYuJs8IpVCeZNnYdfQ6Fb
         jV7xUR6cN2hzw4d7WiI78rGl/YiThUr8LGcarJu8C0Rl7cyfbiSnKJlfFB96aWPxUb
         3fD/OB88W9Q4mGq14X45RN1dB5Zi33RYBTiBb+a8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7KOE-1ijNjM1KAY-00x06b; Tue, 02
 Jun 2020 11:05:10 +0200
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: sprd: call pm_runtime_put if pm_runtime_get_sync
 fails
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8ea80af8-e964-4488-25c6-837f2ac88493@web.de>
Date:   Tue, 2 Jun 2020 11:05:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r0Ml+LxQIhB/V5/UspH+IDLMruxhQLcNn86TeiX5mpWvHOPmUt6
 dhKOevzUl0PCUv6LQ/qbGfW8kgiToEULAjnKLxZXhwVgHcqxTf0Fju6Bfxhe9RlVidu9ebv
 hf/BEG5CbdaCBGIxhXV74/LqpgpLMvq6q+xWfXcApQ9OXAZxzIl5aqtovjSxzoYz3BxUS/G
 exqSPeOKvHJqs0SnGC5Yg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lZgWfSGFN6U=:FdqFp+0W4JZXijtRfp1A42
 Xh+yrYj8w+h/anapy1Z1wO+c+/vpZpLaYN/cq7lUpjH7Zf+aqOaVWaY+Rrmb7/dxFa+xATLGi
 WfXanV/kO0+UNIY7FAHQDSR6M+y2B95ALRdE7hChGj91n0hJEQENeNxIwmoIEvxMdY4Ea+Xvi
 oW6tWQyivByg0YzW+NEFfdL5KOyPlYhpNpkD4sl2bykYTUlB2SUkAGc+kzdwwBzdXWgQETXRQ
 CHwOzdjyuE9dgXi8FxPqwk+vKtOhWqTvVhlFPTzRLLBu9wJEi/0E23zSTyAa9PB1MKdLeUlzb
 0gJmqTb4LgMbOnFJ/pVMAhCZuvTFsgPUmww+PrteYJDnFmpeAJ6pmGI4Z3AXkRfk2LLRplrUT
 KBSZ79NntY9jaY+5ihZbMmszW0Ck/nfuEvXpepTdT7CzZIdEunUzQVmMMmnu99SfZmyQhSd7a
 z5+e7MUUpe7TUFLFfdZ1f+vTAPd1OxgzoQYkI4Hxvp5v2gX3aSy2KP1Cn2yIpkuNGLIpbvvlw
 0Ojqdd/Y6lGhUGSKgvgj8mYMNl419udU0SB3FaJz8CZllJDU9JofBrP3o/L2jGE6ZN3mt/IKd
 8oR9fF+kMu6eJm6klSxLo3y1euFhTn0z6w2CdgAEdEcrLhmSeXZWRRy2Uk0h4IITyRCOB3ioi
 9XAUuCdN/9w4LwCKUZE1UzenW0IWtY2ljNEtlkOgexwVtpFd049zfoNQOC5Pq41owWJCEY0vl
 bwzr0ODRP527qwrTlGlxmF9R0fYBrYsQut7rgfZTgWPurz94VsclPgl3kL3JO0lJBMZ0pTzuU
 UsXjhIj/AGodVmmwEL1jrcAJQvx+WkBMDlfaNNMd2XgD1eh728ypvwksm7erwcz+WKAn8ZHO0
 Q5qpp0Y5kd05yG/iTnz3HU1WcYfN8mLbfEa+fmdefbk0FTLwccilyaUrEF9xJo67+24JVUpS4
 qmH6uE9iUo7BmZ5QwtFK6UlDFcZUQgpVm4rb+rmRwlVO7NE66wuNcTOgnR45Dp9NtkfDAHS4U
 WKRQE1EiaBNefyqZZ8iBmmXycnmgETrKXCco5JRcpi5Wq9rbmGraQeX1KonW0+qMkm/rjIkHh
 zHaLmn26qM0VWvmRSkGz0uznQDCoPspDaPB1Vg/W6+d12q7n4xubORoe1mXDYWUKUI1455uM1
 PfaB0TGyVMOSEO3t2as6TIlilkmBaB2oNRPewP/yddpxkRg1IxzCbbLCHJFDfwcJ2CQx7iN2K
 8xo9BB4COS7LkYtkR
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Call to pm_runtime_get_sync increments counter even in case of
> failure leading to incorrect ref count.
> Call pm_runtime_put_noidle if pm_runtime_get_sync fails.

How do you think about a wording variant like the following?

   Change description:
   The PM runtime reference counter is generally incremented by a call of
   the function =E2=80=9Cpm_runtime_get_sync=E2=80=9D.
   Thus call the function =E2=80=9Cpm_runtime_put_noidle=E2=80=9D also in =
one error case
   to keep the reference counting consistent.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
