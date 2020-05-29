Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C221E894F
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgE2U4E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2U4D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 16:56:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0731DC03E969
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 13:56:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so3355514ejb.10
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZ/bq7BR/UhzFt2ZIaVYJQXvpoJQ+iPR/c67chb9gFY=;
        b=aWxxBonjGPpQG+NoZ8X6be8rLp6luybAHbRe17kn99001BUHe7fnkyDpkoeOygqUCL
         y57pXYrYGApOCXX7pCcI92qN4GPKvfYhPRYt52Xf+Y0Z9QO5/FWUjsSOToY+3yxjIMa5
         S0zEEZbqCMVqNS+r3ntBaVZvnUxyCPrHr0s1gY03uuFOnKg3e3rBeAC5DjRpdiF69yhL
         XGdfiMG6RV4JVsSu7+CrmB9l7LusSrGlEcr+FybouY1i4MyDmum7H2LRTkw12r3eh+Ao
         6WVoTftaBaArYeht6kBFL0LEwFjeK0KCTYhf+Z7yakZrRt2IlJiFZHpdEmUBy1F/V/3o
         UMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ/bq7BR/UhzFt2ZIaVYJQXvpoJQ+iPR/c67chb9gFY=;
        b=VBFlFqbwv/gFpieeJB1VRKJdjv/Lojx3OW+Mu2iN+TkcNaLz/PWFdYNJpvF4bHQs92
         KTehZEOZbBriKUGc5SfCRlkPl9tpQzGRcbZij4tLlmD5QIUex7Ghs6f+sojWqgsRM0+G
         7ZCSLpJyQesAefSejo9+1zEU8npEG5Tt2o5oyqDtSoeVQYMTcWu6G025Lz8tJcPICpfv
         am+wVid/ApUviJeE04E1149MV4Ugl4YL27WL78uu8opCXA2k2UCIliQc3KygJi4nkENG
         jEUlK7jOJSHxr5HDx4D8kbvB95U03xLMaCfA0d4pd1xo91nLp1HCr3GN7TqMU9b4i3nN
         /EOw==
X-Gm-Message-State: AOAM533Gq6cPjnEeEePrgDXkUCun0VURW/NotGgGI1+/jLobA1QVAwLu
        ExlWp/Y78t5ab4I+6HYOZXYCeRNRITrTKy9k+/8EgyXx
X-Google-Smtp-Source: ABdhPJzjsK7/U/zO9ksJnRFeX81y8s/QttSyBgAzfLXi1VmsA9YBV07OQ0mITD0sPCppzEtHE8k/bPEPrvzPB+7VDDM=
X-Received: by 2002:a17:906:af84:: with SMTP id mj4mr3877843ejb.473.1590785761618;
 Fri, 29 May 2020 13:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200529195756.184677-1-angelo.dureghello@timesys.com>
In-Reply-To: <20200529195756.184677-1-angelo.dureghello@timesys.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Fri, 29 May 2020 23:55:50 +0300
Message-ID: <CA+h21hpGJ1F1w8veApdHgs2xn8Uiz8PBQi6nKB1WToEJg+1sXA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix native data copy
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Angelo,

On Fri, 29 May 2020 at 22:53, Angelo Dureghello
<angelo.dureghello@timesys.com> wrote:
>
> ColdFire is a big-endian cpu with a big-endian dspi hw module,
> so, it uses native access, but memcpy breaks the endianness.
>
> So, if i understand properly, by native copy we would mean
> be(cpu)->be(dspi) or le(cpu)->le(dspi) accesses, so my fix
> shouldn't break anything, but i couldn't test it on LS family,
> so every test is really appreciated.
>
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---

Honestly I was expecting more breakage than that on Coldfire :)
I looked at this patch for a while before I figured out what's going on.

Let there be the program below:

#include <linux/types.h>
#include <string.h>
#include <stdio.h>

struct fsl_dspi {
    __u8 *tx;
    int oper_word_size;
};

static void dspi_native_host_to_dev_v1(struct fsl_dspi *dspi, __u32 *txdata)
{
    memcpy(txdata, dspi->tx, dspi->oper_word_size);
    dspi->tx += dspi->oper_word_size;
}

static void dspi_native_host_to_dev_v2(struct fsl_dspi *dspi, __u32 *txdata)
{
    switch (dspi->oper_word_size) {
    case 1:
        *txdata = *(__u8 *)dspi->tx;
        break;
    case 2:
        *txdata = *(__u16 *)dspi->tx;
        break;
    case 4:
        *txdata = *(__u32 *)dspi->tx;
        break;
    }
    dspi->tx += dspi->oper_word_size;
}

int main()
{
    struct fsl_dspi dspi;
    __u8 tx_buf[] = {
        0x00, 0x01, 0x02, 0x03,
        0x04, 0x05, 0x06, 0x07,
        0x08, 0x09, 0x0a, 0x0b,
    };
    __u32 txdata;

    dspi.tx = tx_buf;
    dspi.oper_word_size = 2;

    txdata = 0xdeadbeef;
    dspi_native_host_to_dev_v1(&dspi, &txdata);
    printf("txdata v1: 0x%08x\n", txdata);

    txdata = 0xdeadbeef;
    dspi_native_host_to_dev_v2(&dspi, &txdata);
    printf("txdata v2: 0x%08x\n", txdata);

    return 0;
}

On little endian, it prints:

txdata v1: 0xdead0100
txdata v2: 0x00000302

On big endian, it prints:

txdata v1: 0x0001beef
txdata v2: 0x00000203

So yeah, in your case, 0xbeef (uninitialized data) would get sent on
the wire. Your patch is correct.

Fixes: 53fadb4d90c7 ("spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics")
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 50e41f66a2d7..2e9f9adc5900 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -246,13 +246,33 @@ struct fsl_dspi {
>
>  static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
>  {
> -       memcpy(txdata, dspi->tx, dspi->oper_word_size);
> +       switch (dspi->oper_word_size) {
> +       case 1:
> +               *txdata = *(u8 *)dspi->tx;
> +               break;
> +       case 2:
> +               *txdata = *(u16 *)dspi->tx;
> +               break;
> +       case 4:
> +               *txdata = *(u32 *)dspi->tx;
> +               break;
> +       }
>         dspi->tx += dspi->oper_word_size;
>  }
>
>  static void dspi_native_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
>  {
> -       memcpy(dspi->rx, &rxdata, dspi->oper_word_size);
> +       switch (dspi->oper_word_size) {
> +       case 1:
> +               *(u8 *)dspi->rx = rxdata;
> +               break;
> +       case 2:
> +               *(u16 *)dspi->rx = rxdata;
> +               break;
> +       case 4:
> +               *(u32 *)dspi->rx = rxdata;
> +               break;
> +       }
>         dspi->rx += dspi->oper_word_size;
>  }
>
> --
> 2.26.2
>

Thanks,
-Vladimir
