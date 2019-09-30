Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15971C1B6A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2019 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfI3GYp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Sep 2019 02:24:45 -0400
Received: from mout.web.de ([212.227.17.11]:56799 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbfI3GYp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 30 Sep 2019 02:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569824676;
        bh=4xDHwP7GsaokFa+ZzSb3wiClSs/ehrdmvXIwdvXgQMk=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=qfWp2Cif9eRZsJ98M+/gO1Pocp0aBtxmZlXCWInmCEc3/V4PKhPI7b7WEyZ+QZplC
         5ysVJBBxO7OZ8DPEdwwLgnDVsJq2ZkQQ20VpCXRXw3FkZlepZHFSOo4tovDuzv2Lcf
         FSOjkaNCx+B+prAGUTw1KAvBitZpX/+KgWvFqafA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.97.105]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MI5ze-1iIerd3d6M-003tF6; Mon, 30
 Sep 2019 08:24:35 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190930033928.32312-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] spi: gpio: prevent memory leak in spi_gpio_probe
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dcd26f62-e384-bf6d-2e7d-63c0d0f7da11@web.de>
Date:   Mon, 30 Sep 2019 08:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930033928.32312-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:HAOB9u7KRH3bxo+pLm7aJonGq6dLn3NKqjQyBqXs4e4Jn4ptihC
 o72UISO8k53NizGPMPx2QOz3cCtMVvGN9PCpJjMXZdlIjuKVKoDhkO0MvI4q2Jrl2NkQZAf
 t7VpYFCdOxhxenwxLDZMwwfO3kCBVva/Os3qW+WRcxyLh262p5fZJPwbDVnM+H6WF2dBtWZ
 T6pAiMdJF5ywE9neE034Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tXbA7AauVAI=:q0N4RZbEOloFkIoiRvDZTz
 L8bq8+r9j5/HBYMJ6DzRoDuAdF7Q30gOlHvhKteGxWXh1LeXU5FEzYS+7j6fnZoSB1HysunX7
 oLkkBuPfV8UZk3TdWD9ZdYGQ+2I9H/z7Jb7WBOtAlcFJXm/13r/BbvoM4tugxpDGOxTzXvPP5
 YiaLrzhVY5R7ZYf3ziBULgylJJzZ9HuKg1iSMoAxCJokiIAtwDllfcPUzfseRQtH62iNufyHr
 PWsurRg7ThBwWHyr9q26ugWHpaO82H6ZRlHjkhT0PGk4w3q1wXW6rzVwQ5qm9Ittehl99sxwl
 USpJh7U/kXuR6Wow6Lzn8AQiRP7suku52iNZddgw9Q6ii70Q4rJuqFb3ovwl2XUwTDyhiuHep
 jQYzQq7pyZTqTNI6rzQj2/NPM7NcsFs+PmuXFDhokVMiwQi1p0Wb/pLPAAZwq1vXEJy60Pv1W
 TsXKwWKqXRHLx4gxIaaWprCq6YfAw77sJy+ItSGKmJTe2U7+Nou7zjmi4WvRxcuemPe7oRoTm
 gjXpGWTlAxc9+swFMhoDUw2w5TxTNf5QI31EEd56ZUc3xOroq+ob2vY59iQVuQ/WhC9AnFCaK
 EAkEQfBr3oxJmvGjewvcpZWNNuM2L3dUjMkeQgR+NUkZ+j3WwCMqnN7rXdbdOIahWkEODwTJe
 GSG17iYNGhMZQ5ZBfZTWA8EM3MLey55CdzBurP0fvJLsmGbmBntheU6mCyTbEBUMGFvSrHSJ5
 aMwpE3OZWvxwDCU6evnAVf6h3Ib8prNeV0cS0SZ/spcewdBrcgPGlsBVdJyV7aFiQsuPlhaRl
 YejSqQg5hf9vQ//GCPWXJ3RsaXR8WgQ5UQrSg3yvLLEfhypAUF2tDkOeMa8gMbDjCWjsL4Hfc
 lUuRNWpfflp5X3ri1rNlTZxsITGgAAJ/D8byzjn0uNcoXRXcxoB5H+zq4twUFA/6MKy/9g/4C
 u9bMRFtHhTqTyXUlYvkobOJOg6W4npwAhKOVMvrE6K1Lu2EAmrBOSmT/GiiVndXK7ckmI8prO
 QxSy+hI6L5FPUwZC5J7+h9S46z97ivqsEgfbUVtBaU51Zos74qhLE+VD0Hajd1pltFR7rRuKu
 0Lz66qDY1I7zkrp5if5GCJHZwIuHIGRyKNkrCysKsUlbeDG6siA6ADdmerWZg47Jo57pqsNWM
 z5LcPqvtGm6Bx5hN00/4DOsLi8udF6Gxn3Ildou2AyMD/LfG9muB+e5fkEDmO5bV9FlGM3cYU
 ulROj7UPZb/F5BcUHZZLIO3v5UGimPnskDWAnIHAnDa5GvPpfNW9Ypt6VlYw=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* Please avoid typos in the commit message.

* I would prefer an other wording for the change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=97f9a3c4eee55b0178b518ae7114a6a53372913d#n151


Regards,
Markus
