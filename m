Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A8E1BBC00
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD1LKZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 07:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD1LKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Apr 2020 07:10:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7840C03C1A9;
        Tue, 28 Apr 2020 04:10:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so24178326wrr.0;
        Tue, 28 Apr 2020 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPJ7zElmu1fDMecgiDY6nmp40JbRN8763I+n2XOKcx8=;
        b=eQvn/AC2lcMkF4QSUTuEI+jLFcYi+FGIV97UXglyGL6UHbzUxmYeMN54Jl+rEes0cg
         FYGNpQDypfR3JBWSplsorENXeCSdG8gxJ/fXceOutQYC1VX3piOsQykiu2gDaoWv6WTK
         /rhb2vOTgZwD0iFx46SnsH942KRApUTQzN6/bn3ZQYPMA2d+avEipmJb6kpG0kl0u7Kw
         0l6GWCYHalD93vqYUEqbg65g9nPCN1QdfcOoQG203Mcp7wG76LNgoaG+e7EP5N4F70Sc
         utOzm2V+izsh4Z8qpBs9MYKs3N35pHASTI8dPponvAVY9cg+Q4EuQGDXU/BqDsYgbAQ5
         EJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VPJ7zElmu1fDMecgiDY6nmp40JbRN8763I+n2XOKcx8=;
        b=D8cmT7WA8V245j6fMlEX6a/zSJY6ITd9o3HoM11r9zPzfwqO5lxm+K4pw9l4gZQJsU
         Mh5pmZvJM40EBn76B44XdJK7Ns+Ij1AmANNtQuJyBnn8YLgHadZzQa7Vv9Wyg9Vq5WgA
         SHMuoW+9yNW8H18umZzdBR5PslMa9cahbOF1LOpYViC7IzhhuMfyNn96ZzPIyy2/3if+
         /eVjz3TaZi9zDMfjbxGfTcr8IVASGBxLNBmfq6Lu+k6K107sO7mJiVCZLUkuAoKMBu+B
         ntqgBADPd1ez6qEIXSQuQq5N4aPCcVx47kIORDDJUYEcLEXMxyqnGTnDYkU7R4relKRT
         kOmA==
X-Gm-Message-State: AGi0PubFtkwUhMh4OciFcXgxLgdAsfFIe7FLr/rrlqBU01ETCwFEFwEJ
        n2lsfQL49fDSZHJRFqLYJj0=
X-Google-Smtp-Source: APiQypLhYXVQWxa+FFi8UFXLGTaIqA/8WGlbmBEshqnoqn+VnVwUYBfkDBUTid+j2Wpqr5xgOypElQ==
X-Received: by 2002:adf:f450:: with SMTP id f16mr32536199wrp.346.1588072222245;
        Tue, 28 Apr 2020 04:10:22 -0700 (PDT)
Received: from workstation.lan.schwierd.dedyn.io ([2001:16b8:55e5:7101:cff:b6ab:5886:a72a])
        by smtp.gmail.com with ESMTPSA id l19sm2887431wmj.14.2020.04.28.04.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:10:21 -0700 (PDT)
From:   Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
To:     Dilip Kota <eswara.kota@linux.intel.com>, broonie@kernel.org,
        robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
Autocrypt: addr=daniel.schwierzeck@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFiCxHwBEACqCqGeCoJ4eA3iVPRzFal3opTtAIqztUJvSqXzCFBaFOJeD5sLkxfhj9BQ
 +UTHfOmyt+1zBNmOWeaWYpHtpFhoTxu9slIxsbr7GbAy0aGqOCcg4W3TlUgfTMyWEo6XaCR1
 /4nQ5kEsMubjI3mdExnLgUE/JIJ71Nj5lbwQN7MLKfXwq8DT9EKCeW/X5hxbb/MUzHzI6UQN
 0egYB0dGiqmSwTCauaCnJetGqYSConkTtOMewpMwIRxhaEiqL2qdKPX5EwMLAe0ls0Vze5EQ
 GNI855ybRnF33wuszIYgOYAb0/yakTkjfVcPLRTtPmzBkLtNyREEdij1sFD73aRuN6dLZrmi
 3e5ieIO4/kHoT6LF/l+WzTS05c3M7rSwzFuBf3SX8PSe+ubEbZSfJzoOoo/L8wtPfd8liOJI
 XpHI/iYSIt/sJZtEhNPErUUajpIuHznIeAHbJAUdDJFwuNzlTisgOwfvgfX1VegLVSuDLElf
 vnA1h0HQ0t+wGS2eLJOlSFpujrtyIOt0oZl2I/qGWXkap2aFIPKdmArAFALbtPiynpt3hNEv
 FvNYlDedM/TDQfFtAFA2P2Y1lnJGvXANsJAfQ1/nkqcYw6xPtNM54oL6HeltTR7YIadnLSgP
 PEVlObpM+i3jNvhm7QbzHoX1dhFuIoD5L+wzf7mHUyvLsJz32QARAQABzTFEYW5pZWwgU2No
 d2llcnplY2sgPGRhbmllbC5zY2h3aWVyemVja0BnbWFpbC5jb20+wsGABBMBCgAqAhsBBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAhkBBQJaZKBlBQkLR91pAAoJEKkMSJA8fb5WCRwP/Rg6
 ZcyNBA/ztPa29BFwPDHSkNOdi1iKsnnY/5N0rNQu2w/UwhaOhEjj1bOUsJMIT3+1+KgKL9Ti
 90qTQYHUEctedLXPM1wZIqnK4R3LSzIzTXU+DMk7AU2wacpZZl8rf1sfUayNO6nDSqO3kK0a
 wdgwuaYTLIQwrtnxKL0cQK4wS4LX5+o4CUN+cpKJZNy9pOkiTnAIgXRxfUxCfS5ZvW2PvOv4
 HTwPE9KQC0xkqMs4W2g6RTdebWjb+Wtxhlj4mWVD5OIhHH583GWjoWx3MTUY4rgxRLHABAmp
 sDN3PEmaGMqI0ddVFZX9p5+g0IRxKvEpxzHVAiuI3+uYvYRCUAnAkUdyUP09tNTShBqiTT2l
 K1HfVZNYdAyI0P59Y591iWdPT4wE7szRLDYYIt6TG84WNi4TFfaf4XtgHgLCqQ2GCVodCdM3
 fW9QAsauxYOWoF76fdGaVQ5tMhiP81r4+xI0cE+VffjHfSwupdor0Nuv/05WcqjsHFPy+j6B
 MKfGsf9H3ZCOXp46WXenMGj5oXXHuwss+y6y+rhzhXLKDhfJGsf4b0Mb2pFDVyCnm13dG+WS
 fpMj8JmdxujgvhtZlSn96DTGVUsa++ctVIt40kvDJLPa7fw11oPrWyJ2jholmN1oX7yKHc2H
 ZFMc2t9KPEVy+uEH3DpSnX0wA+AE0/p1zsFNBFiCxaABEADIy6QrxEkvgFvQxJLAGckRbOPm
 aiEMXiwmITVGTKTK0RnCRrQXrUkhXZGFgVGEua0WvS5cRB+UCWRNRo0Gsi0m/T8gEZPUpaEO
 9qyQIpXDru/fdBKfWwh+UWnXjdjQ+ZKHuzgRrp4weMfmIG45R1L35j8UKF4wgoSh+toJ52a0
 4MrRLj/mLZHjQb2xYg1HnDG012FwgsfOaTj0IHQG6DAG2wAbiFaDKKANStGH+DZWVJdhDQzX
 IRHMDiXxChuFxSmpMhDCk5CCZ9x1w1EwXK5dIizL90diMrhxWE96WGWz7F0O14YoCnqTrVTF
 ZWLQATWBc7Yz+ujgtyJBbV0Jtkbr7TdWg44uc/8G2EjHZciDVyfo4BrqDEKGbl7Yp3pfmggz
 fgPDg11RUal4wo80UkKKKjHNVkBCVP0g1K0hVRvLwKLHj9/w94xfGKXHU9jGvyFD2qO6izAk
 dCvFwzPxwAKSSehIdE9OP4J1D2uKIVhN8xGv+iTIlri+dNGdBRZKzDgSnh0BNZIeZatjkGzb
 UfI+6B0ECAyUN6ktfb9xd2JJTYFjEQ8mN+/1PjafNMADnH5DtI6BgFCnJNC35nytySbFcKJL
 oQq9YU4RNxJmbgsmKLczZiKa6u0Ltwo9WBEQFH4PFLx6Rl+fMBVhsGbrJMQyJDlddaT7fgYN
 O51qGyTt6QARAQABwsOyBBgBCgAmAhsCFiEEjE4isOl1TXE3Jl+BqQxIkDx9vlYFAl4q5tQF
 CQeTyBACQAkQqQxIkDx9vlbBXSAEGQEKAAYFAliCxaAACgkQKPlOlyTyXBgLCg/+NFabLQEU
 +Z1g4WWPEQzLvJ5J0WwwGGUu+GsYls9CuSGURquULBeoBWZe0MhFKZ3RCaCUMk4gw2qAR6Hj
 PulZO8QUduRQxD9JzLrv92fUip0qd2zHSlfbKRBHmZhAhVFAs1sTVg5dgNcOnkFqTpvR+vVj
 mnUUWdGv+9p18+ofCSASh2NLyVIjjYW7Q/hnATt0HS3TxX4veqr15kK5yfyhefWcUfw0JXac
 4tvs2jqFIVnm/vCMIwijWU5qiTuqoYU+d0xVaaAt8HswCwsXVYCIRzQHWjNCvh0/M4vegU1B
 7SjJQ1qbbClfnZ969Br+8VuFmCm/FgaQf5RQPYCOXNTWPrX6uZngnT2OwV3v74BSVtXw3+Tg
 Fb6aw6m4745lcd2xb08xGMe7OlbXdK2NFuab4V7om06C5SlxV8Nt4WBM9LZwnrVdfVf+8Dum
 6Nz9Ig3rHzgnJAX1EARdK/ZdVuIvx4rSGX8kdeB9m+pmhXpqV3+IJf6mO1zxASwdSXvwIzwN
 +PVKB2AUgHOuhAEty/HhH7NV0peJfeECz3YMDxUUlPhFbGlRZZZliia5XHLBSVQXcQjRdDIJ
 ceA8LHbWMxqDSdWyqieI1jo/h4dxeJkcg7h8Dm92aLcwIaYLdIoqF+u+IT0noI6v8rgAfBmi
 ke+MNPxt4IQp9D+d1nz7I2EOOXUWIQSMTiKw6XVNcTcmX4GpDEiQPH2+VoVgD/982U/Kg+gP
 jWeJ55XTl9kJoDPXjKz1JJK+VwWtZ6vSmwG9hkNI+O5RqqguGUZgeeZw2ixMG3Qc3WUOYhBg
 XANByza6Pxs20nPUpmh5pnczvkTGpEmtfQJMk+tdk9QiUAip6iJ5Y8v2Jno9iFdyUIhlHyHT
 ldR6Nu5JkiqXEKrGr0TNZaGLG89jEVLbOUgjo+xtjIasjxRj1KPmq9GHSXZ6+pPVncxpXFL4
 XtwukcBS4yhPFIU1k2DE69PjxZhrLZCs2oS4ggOcdQGXWQ/nyNFbdXnTfmPNUytAA5/Y3PIv
 bmb8B2+qcoCItqxEnaIH/0XNnFgA0RPl4hrPyjdBRPkBa9Jg2MG3dgzjrHJWE0hAjQ/fcwjc
 YecctuPr8pdtpdhT/NmDBKwuXkKWjp2l8sMdE73rUh9T/hOJZWP90EXxzzJyVunSJpATZoHf
 8czPpT/VM2chUss6B1xgrHU8IABssThU85R6GJScnPHh/9Mevuf5MlO8F2ypfHz0IZcp1YwA
 Nix3j2zbKJqLq4oT79IY4h0ai+ZBPNqx0fQsMYfYAnIrJ20p0b0x9UcySVDqTBhfmkJRV0AZ
 oWRxl9V+qRXhvGPL0uA8dRfaSUWYN5GAfuTL7AIpaywgu8E0WqIAihJ5F/cTP6/y40Rgxtjn
 CrEceoCb6dBWOM6yjVPkGPlf/c7BTQRYgscDARAAwJTztXe1EcemRoDrIj5Ft1js7nQeHjqw
 +gOwdOAZr/gOqD976R+2OVOyLVm+cWBTVkTTinNB80A6LrXQgb+qMs9VnT+dgN1ovu0yseRa
 DPSoMOR2W9faU7PU5KeAFYHAIrp+e5xp82QgCyfeG72zTMggf+saKV9iF8EHnMgm1WM3dBFw
 EwlhwWAGVT8kSYTsbkX8nxP3eg+SmZmTY9izpGGvo8yr6oMDTTK1tQEHDu93naujajIfMCXF
 u3b2viYVPPynI0qIYtV317d0kSuKgFg3duYaoX4cp0vTkW8mT8tfla9/bz//nMiVxWPNezYS
 yWdNi+n4khKpYkD9UE09lfUjLOVyAxu+cEYUzwsbd5r8K89qBtQDmRzLDWXz9g3EsourFRsJ
 09khDOcpZNRGca5S3tNO97RIu8Btxmk3MmSXAWQZ+M6hyCxAHxLnqzWON0EOYxYgj+WVJGcJ
 4g+F+AuyiYwsy/ct0FOb7yNSE3pUpps17aeb26Ma+k3SUWtJ3Dc4ovEO+2AUJ2xg4Cgr4Ht0
 cd0Ru1zhMXLGhGdyMHZnhdp6hc6XQNoJKrSvtXuYtn1bPPBo0LqSsx5iZywq/RwNrpi64qkT
 pqGPhXHTiimFN1Xy0hkt9ACZBDNFgH5Mtd1lWnaClgMqQ8hvUcSNttQrlr141LK5NKu7vPJC
 2f0AEQEAAcLBkwQYAQoAJgIbDBYhBIxOIrDpdU1xNyZfgakMSJA8fb5WBQJeKubfBQkHk8at
 ACEJEKkMSJA8fb5WFiEEjE4isOl1TXE3Jl+BqQxIkDx9vlYswQ/+LuwYOVJ1ZbXxcv7F+Ql6
 corUp4cNnZpTnoDElnKGKMQPkFh9q5cTHZe3GmoKvJFGxiEGLWfAYhUGSomAjhhqD1N9tSVI
 ycH51GdtKcEIjUsH5P0x3zjiKarqFm27Or08dyJrjeleZPz0JvAVcf3Mn4dKmZwSUuoxdnnN
 IrJ0e56kObjJY37n1swCfHQVH1OwatR0lOHE4D8V3t0YoKpJlrApT3Dkn0cWAt/sbZ3jFU4F
 E1NQZC4XxZ/f5/6SnWN5v+6/+HvaVJDHpbS5xR6/27CvWUup4qefAkMgfNzTjm2J2vYT4Lbz
 sdz9LeGTgI9maYvq/nvFNNtqC5VfQO6dbpzAO+Lytiah569dxtYDqGPm0V3E2U2CJxbRDo99
 QlxLj6Y19OcOezK6hJ/qyHe2VvdGkGPLDJZccvNmb1L1q3s5B4MZU6/G9U8mM7kUwjBjD6pP
 tZor7Hr6d0zVB5JnGvvN1XXZnEaCP6ochfpLIbR2TygzOo1aWJgI5x97BjnQvJOh2sc/wlQa
 wD8t7NvqilPcpPnfaQzlMtO0v1wkuwubIxEG9PUZdarQ6D00gUfRarIUXMcBQryGrMJ3rxqf
 XdaQwC7Es8AKVlLSetZFk1QLOooVLdbk4s602fHBsjaOo1TJh2FD2vXyZ4mtJ/rlqLwsl38A
 ymBWdr+OK+rfiw8=
Message-ID: <310ca761-e7ae-1192-99fd-a1960697806b@gmail.com>
Date:   Tue, 28 Apr 2020 13:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Am 24.04.20 um 12:42 schrieb Dilip Kota:
> Synchronize tx, rx and error interrupts by registering to the
> same interrupt handler. Interrupt handler will recognize and process
> the appropriate interrupt on the basis of interrupt status register.
> Also, establish synchronization between the interrupt handler and
> transfer operation by taking the locks and registering the interrupt
> handler as thread IRQ which avoids the bottom half.

actually there is no real bottom half. Reading or writing the FIFOs is
fast and is therefore be done in hard IRQ context. But as the comment
for lantiq_ssc_bussy_work() state, the driver needs some busy-waiting
after the last interrupt. I don't think it's worth to replace this with
threaded interrupts which add more runtime overhead and likely decrease
the maximum transfer speed.

> Fixes the wrongly populated interrupt register offsets too.
> 
> Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
> Fixes: ad2fca0721d1 ("spi: lantiq-ssc: add LTQ_ prefix to defines")
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  drivers/spi/spi-lantiq-ssc.c | 89 ++++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
> index 1fd7ee53d451..b67f5925bcb0 100644
> --- a/drivers/spi/spi-lantiq-ssc.c
> +++ b/drivers/spi/spi-lantiq-ssc.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of_device.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> @@ -13,7 +14,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/sched.h>
>  #include <linux/completion.h>
> -#include <linux/spinlock.h>
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/pm_runtime.h>
> @@ -50,8 +50,8 @@
>  #define LTQ_SPI_RXCNT		0x84
>  #define LTQ_SPI_DMACON		0xec
>  #define LTQ_SPI_IRNEN		0xf4
> -#define LTQ_SPI_IRNICR		0xf8
> -#define LTQ_SPI_IRNCR		0xfc
> +#define LTQ_SPI_IRNCR		0xf8
> +#define LTQ_SPI_IRNICR		0xfc

the values are matching the datasheets for Danube and VRX200 family.
AFAICS the registers have been swapped for some newer SoCs like GRX330
or GRX550. It didn't matter until now because those registers were
unused by the driver. So if you want to use those registers, you have to
deal somehow with the register offset swap in struct lantiq_ssc_hwcfg.

>  
>  #define LTQ_SPI_CLC_SMC_S	16	/* Clock divider for sleep mode */
>  #define LTQ_SPI_CLC_SMC_M	(0xFF << LTQ_SPI_CLC_SMC_S)
> @@ -171,9 +171,7 @@ struct lantiq_ssc_spi {
>  	struct clk			*fpi_clk;
>  	const struct lantiq_ssc_hwcfg	*hwcfg;
>  
> -	spinlock_t			lock;
> -	struct workqueue_struct		*wq;
> -	struct work_struct		work;
> +	struct mutex			lock;
>  
>  	const u8			*tx;
>  	u8				*rx;
> @@ -186,6 +184,8 @@ struct lantiq_ssc_spi {
>  	unsigned int			base_cs;
>  };
>  
> +static void lantiq_ssc_busy_wait(struct lantiq_ssc_spi *spi);
> +
>  static u32 lantiq_ssc_readl(const struct lantiq_ssc_spi *spi, u32 reg)
>  {
>  	return __raw_readl(spi->regbase + reg);
> @@ -464,8 +464,6 @@ static int lantiq_ssc_unprepare_message(struct spi_master *master,
>  {
>  	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
>  
> -	flush_workqueue(spi->wq);
> -
>  	/* Disable transmitter and receiver while idle */
>  	lantiq_ssc_maskl(spi, 0, LTQ_SPI_CON_TXOFF | LTQ_SPI_CON_RXOFF,
>  			 LTQ_SPI_CON);
> @@ -610,10 +608,8 @@ static void rx_request(struct lantiq_ssc_spi *spi)
>  	lantiq_ssc_writel(spi, rxreq, LTQ_SPI_RXREQ);
>  }
>  
> -static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
> +static irqreturn_t lantiq_ssc_xmit_interrupt(struct lantiq_ssc_spi *spi)
>  {
> -	struct lantiq_ssc_spi *spi = data;
> -
>  	if (spi->tx) {
>  		if (spi->rx && spi->rx_todo)
>  			rx_fifo_read_full_duplex(spi);
> @@ -638,19 +634,15 @@ static irqreturn_t lantiq_ssc_xmit_interrupt(int irq, void *data)
>  	return IRQ_HANDLED;
>  
>  completed:
> -	queue_work(spi->wq, &spi->work);
> +	lantiq_ssc_busy_wait(spi);
>  
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
> +static irqreturn_t lantiq_ssc_err_interrupt(struct lantiq_ssc_spi *spi)
>  {
> -	struct lantiq_ssc_spi *spi = data;
>  	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
>  
> -	if (!(stat & LTQ_SPI_STAT_ERRORS))
> -		return IRQ_NONE;
> -
>  	if (stat & LTQ_SPI_STAT_RUE)
>  		dev_err(spi->dev, "receive underflow error\n");
>  	if (stat & LTQ_SPI_STAT_TUE)
> @@ -670,17 +662,39 @@ static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
>  	/* set bad status so it can be retried */
>  	if (spi->master->cur_msg)
>  		spi->master->cur_msg->status = -EIO;
> -	queue_work(spi->wq, &spi->work);
> +
> +	spi_finalize_current_transfer(spi->master);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t lantiq_ssc_isr(int irq, void *data)
> +{
> +	struct lantiq_ssc_spi *spi = data;
> +	const struct lantiq_ssc_hwcfg *hwcfg = spi->hwcfg;
> +	irqreturn_t ret = IRQ_NONE;
> +	u32 val;
> +
> +	mutex_lock(&spi->lock);
> +	val = lantiq_ssc_readl(spi, LTQ_SPI_IRNCR);
> +	lantiq_ssc_maskl(spi, val, 0, LTQ_SPI_IRNEN);
> +
> +	if (val & LTQ_SPI_IRNEN_E)
> +		ret = lantiq_ssc_err_interrupt(spi);
> +
> +	if ((val & hwcfg->irnen_t) || (val & hwcfg->irnen_r))
> +		ret = lantiq_ssc_xmit_interrupt(spi);
> +
> +	lantiq_ssc_maskl(spi, 0, val, LTQ_SPI_IRNEN);
> +	mutex_unlock(&spi->lock);
> +
> +	return ret;
> +}
> +
>  static int transfer_start(struct lantiq_ssc_spi *spi, struct spi_device *spidev,
>  			  struct spi_transfer *t)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&spi->lock, flags);
> +	mutex_lock(&spi->lock);
>  
>  	spi->tx = t->tx_buf;
>  	spi->rx = t->rx_buf;
> @@ -700,7 +714,7 @@ static int transfer_start(struct lantiq_ssc_spi *spi, struct spi_device *spidev,
>  			rx_request(spi);
>  	}
>  
> -	spin_unlock_irqrestore(&spi->lock, flags);
> +	mutex_unlock(&spi->lock);
>  
>  	return t->len;
>  }
> @@ -712,14 +726,11 @@ static int transfer_start(struct lantiq_ssc_spi *spi, struct spi_device *spidev,
>   * write the last word to the wire, not when it is finished. Do busy
>   * waiting till it finishes.
>   */
> -static void lantiq_ssc_bussy_work(struct work_struct *work)
> +static void lantiq_ssc_busy_wait(struct lantiq_ssc_spi *spi)
>  {
> -	struct lantiq_ssc_spi *spi;
>  	unsigned long long timeout = 8LL * 1000LL;
>  	unsigned long end;
>  
> -	spi = container_of(work, typeof(*spi), work);
> -
>  	do_div(timeout, spi->speed_hz);
>  	timeout += timeout + 100; /* some tolerance */
>  
> @@ -838,18 +849,18 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
>  		goto err_master_put;
>  	}
>  
> -	err = devm_request_irq(dev, rx_irq, lantiq_ssc_xmit_interrupt,
> -			       0, LTQ_SPI_RX_IRQ_NAME, spi);
> +	err = devm_request_threaded_irq(dev, rx_irq, NULL, lantiq_ssc_isr,
> +					IRQF_ONESHOT, LTQ_SPI_RX_IRQ_NAME, spi);
>  	if (err)
>  		goto err_master_put;
>  
> -	err = devm_request_irq(dev, tx_irq, lantiq_ssc_xmit_interrupt,
> -			       0, LTQ_SPI_TX_IRQ_NAME, spi);
> +	err = devm_request_threaded_irq(dev, tx_irq, NULL, lantiq_ssc_isr,
> +					IRQF_ONESHOT, LTQ_SPI_TX_IRQ_NAME, spi);
>  	if (err)
>  		goto err_master_put;
>  
> -	err = devm_request_irq(dev, err_irq, lantiq_ssc_err_interrupt,
> -			       0, LTQ_SPI_ERR_IRQ_NAME, spi);
> +	err = devm_request_threaded_irq(dev, err_irq, NULL, lantiq_ssc_isr,
> +					IRQF_ONESHOT, LTQ_SPI_ERR_IRQ_NAME, spi);
>  	if (err)
>  		goto err_master_put;
>  
> @@ -882,7 +893,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
>  	spi->base_cs = 1;
>  	of_property_read_u32(pdev->dev.of_node, "base-cs", &spi->base_cs);
>  
> -	spin_lock_init(&spi->lock);
> +	mutex_init(&spi->lock);
>  	spi->bits_per_word = 8;
>  	spi->speed_hz = 0;
>  
> @@ -899,13 +910,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
>  	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 8) |
>  				     SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
>  
> -	spi->wq = alloc_ordered_workqueue(dev_name(dev), 0);
> -	if (!spi->wq) {
> -		err = -ENOMEM;
> -		goto err_clk_put;
> -	}
> -	INIT_WORK(&spi->work, lantiq_ssc_bussy_work);
> -
>  	id = lantiq_ssc_readl(spi, LTQ_SPI_ID);
>  	spi->tx_fifo_size = (id & LTQ_SPI_ID_TXFS_M) >> LTQ_SPI_ID_TXFS_S;
>  	spi->rx_fifo_size = (id & LTQ_SPI_ID_RXFS_M) >> LTQ_SPI_ID_RXFS_S;
> @@ -921,13 +925,11 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
>  	err = devm_spi_register_master(dev, master);
>  	if (err) {
>  		dev_err(dev, "failed to register spi_master\n");
> -		goto err_wq_destroy;
> +		goto err_clk_put;
>  	}
>  
>  	return 0;
>  
> -err_wq_destroy:
> -	destroy_workqueue(spi->wq);
>  err_clk_put:
>  	clk_put(spi->fpi_clk);
>  err_clk_disable:
> @@ -948,7 +950,6 @@ static int lantiq_ssc_remove(struct platform_device *pdev)
>  	tx_fifo_flush(spi);
>  	hw_enter_config_mode(spi);
>  
> -	destroy_workqueue(spi->wq);
>  	clk_disable_unprepare(spi->spi_clk);
>  	clk_put(spi->fpi_clk);
>  
> 

-- 
- Daniel
