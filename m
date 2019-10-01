Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF3C2FBD
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbfJAJLs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 05:11:48 -0400
Received: from mout.web.de ([212.227.15.14]:48655 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfJAJLs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Oct 2019 05:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569921095;
        bh=O1+ib/el6hAskXCZ47QY12NI7OM9Gr1X0UJsybH/Ec4=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=ZDSWY8W6gTpCn/HfEOwkv/5jSD0eiNuPiMkVzPZif8H+J6o+jo3wsZ8xPyjmu4Pk7
         QJyuLteGXSEmaLaDjrBOYriCktmY1OnCe1kwGWe3xklzrkE+5ZEYw6+TAwnZP1aYek
         wTs3qTg16nkwWEYaZMxNaJztCkAOZUErSfbW+ES0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.188.160]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTQ07-1ig0mm22MR-00SQXp; Tue, 01
 Oct 2019 11:11:35 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190930205241.5483-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH v2] spi: gpio: prevent memory leak in spi_gpio_probe
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Message-ID: <6b55e753-5797-2bdc-fae6-f575a0ef8186@web.de>
Date:   Tue, 1 Oct 2019 11:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930205241.5483-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jZsjtxl6if1gzLVF1Mzz15dphAQ/CccCjWM/+B3wf7CJCJQwCVQ
 +dOp6jmq27u998hu2O/2ecrfN8suRdUFRxDEdN4/T/iiRrbsRUXI+NQCkLgRVuzEmbQkuLP
 W0PDxpuuen5s+DLLqNKMFDGk/1BT/iTDa6WzRhEj+GPRKSTA0OugbevubXq+5ID6DlgB9ck
 VF5zxcqPtOb0SD1oevcpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IIJEcY27J7Y=:jX24TyPcBlJgneYwSLUp4c
 6Abc0lAUCBAufCevl154h7T0Dm4D9EcO8U++VftTqX9wwR4oPMPYDk5obMnVB1QB1vEV8JuYn
 iH15ZKVJt2Z29qagI0xKjxGveXq5t4AkPSF0VYnEgVa6wkKEuHQfDa+GeTmSosYF+2/L5e4R1
 S1fRGUY9JMhMpKyMvL6MeSluvi5kMaRizGfRv6ZRLWfHOE4iQCrdqnV4/YOxMVHPNFokt9eQm
 t0KPX8Lw6MxaJa/x1g0WAaJRSss4gXN7/h8MU0VfGJJJTkTpNO649cGqlfD7L/PJA5giC5yso
 Q4hUtfyJ3hj7oWVx/S2R02xiIcEQUfq+oSuVaKBml20o3izdV6oJPPRvMgthgksi7j3I1yLcO
 IHsKdNboS/DHrknBy27NIIvy+81udv4juEMcSPZNWOsHg4o/1NewzUcDGe/1w0q74tdurWha3
 0dQDV0P0XLCOdz07ZWKGynJ+kIFoiFysM+TQw2OBcqyR59/FmPCG2TKePRidBeOt0/znSKIE4
 a/opn1dlmrd8ShGYHTxMbs3QfaIvgUF8cTMNKJGuKHZnxPg/SG6H3gnjdOTAS2OZAjb1t154S
 Pec/hsDtwjjAExtRvzVc1nB1/Z7VHIX7HTEwb99LorXn+HrFu1BpsypGvLFdNXjjIS5yKhXJD
 9lM9o+QEqgQPM6vX8XoE8I5g3ke20pnkk2OFtvoANVf8mpFMIi9U5qaNHSivqKRYrLoZ8T5Wq
 FSgRf5hpuM75Vl0As19gp/Q8Bgp2Gnk+SaQuhB710SDVKqwi8vJsKK1vC77pJwsgLAa4MXoSI
 Prpro76F7nj0XgIdSVwNV1fABBV9pM65YILDYaR2XLr10J/m3xvvfp/LZo0WudDaQlsPEG+mV
 cKY8UbEQL7N57DLlleffwZCZ5N2MFOamznfg+V0BvccpVWTwFyWW1YFi6UPUL4Tk6YFl6nJTh
 8r0jIDrNVgO+Y7egexFm49ojOsfk3d/3kQmsJtYrCqQZ+tPv91qoAWn1SZ763pebcwbbaxg5F
 o9cd9+9FbJJt3OVCXsgg2UBK3wX6NVTqDLMQa0EF7ZQ48S/xMq365ALNkQVSSb8+bJWDgBKrQ
 knWDWd2d+F1XI4WXkekcbmR7Ms34AFJOMAuEzS1XHfAVwKgCaffy/wIHglHRjadB4Ff0LVWaC
 8qr72GztZdEZeYeYZELwculHT19aTfgGULfxA1jY4UOBcgs+Ig4HnT4b6fDrgFK16EHStnuvy
 toTGlZ041r62wQ0gvuE6pwJRfU1YleXH0/UA9s8Kzueg52BqOA8TsRGelm8Y=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> =E2=80=A6 In order to avoid leak spi_contriller_put must
> be called in case of failure for devm_add_action_or_reset.

How does this wording fit to the diff display that you would like
to add the function call =E2=80=9Cspi_master_put(master)=E2=80=9D in
one if branch?


> Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called in=
 every error path")

Is there a need to complete the corresponding exception handling
at any more source code places?

Regards,
Markus
