Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169F63486E1
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 03:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhCYCU7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhCYCU3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 22:20:29 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA828C06174A;
        Wed, 24 Mar 2021 19:20:28 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q9so449524qvm.6;
        Wed, 24 Mar 2021 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuMccf/7GNbicUmR6VyO6cnA/nu+0C0TDjY5czjZIEc=;
        b=GEWZhBJIKlTAGwEYqWqYIOlwc2+gHdNaHQVQ8WtLn6zNbHwO9ZYQlUJ1MOw4RQXQ82
         06iUx37ugrhzLyHe7zsy0XPNUdTUeDsloekiJeJowLL2t89sTzCfdsuEkg9WguQiE8Ek
         QvLgF50IQnvSX7isygVk/w402Epl06VDGUdNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuMccf/7GNbicUmR6VyO6cnA/nu+0C0TDjY5czjZIEc=;
        b=k7Ey0W74MAdOarCEAwHpfTGJkYWvC0DnqxBczd1xuvV1BOtne2qhjgmDth0l1rfoa9
         voetMGGRQZ3TdshGME/6KClHZZ4H7vtQ1XHo2ILJTlBgtLb/sQy6fIh5m77w0uuHHP9u
         WJk0nlg9WW2R8G4NSKB8JwYqk/CZg6BNP17pw5VC5noK905JVPqtFs0cUe6S/Zzt414V
         eLNt86eSxQFDC84HBctYUAt3fCEkVn/wI4qjDp/Tsob2uUmUvpi6xvASsEEdb88EBH7L
         mPUg0zs217GnX5UXBZIkeJK5Jx/B4iBV+q9/M0kBiP/oG4N7iaaNwK7zsYikL+HfRZrb
         OPpA==
X-Gm-Message-State: AOAM530wCBANK/2/FPM/3lcpI8+KGG8IjTiRzv3MPAiW1NP8HYW3Ufry
        tXGPaSrNZ9ef8iI6A0b77UkOi46ngqjRnaZ/O20pF+zSnJ8=
X-Google-Smtp-Source: ABdhPJzYkjmv4WDutq97vzp5KAtJ4JMda9zt5+cWVGqQXmWAUgANGXoLilJm0skX18oeMuFyEl+NmsZYjMKHrR+PABY=
X-Received: by 2002:a0c:d7ca:: with SMTP id g10mr6081798qvj.16.1616638828073;
 Wed, 24 Mar 2021 19:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210324220516.41192-1-eajames@linux.ibm.com>
In-Reply-To: <20210324220516.41192-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 25 Mar 2021 02:20:16 +0000
Message-ID: <CACPK8XeO7Oan+xBwOJ6VUfEF_gMs=NJ=rvVZjrFXczb4-YtCdA@mail.gmail.com>
Subject: Re: [PATCH] spi: fsi: Remove multiple sequenced ops for restricted chips
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Mar 2021 at 22:05, Eddie James <eajames@linux.ibm.com> wrote:
>
> Updated restricted chips have trouble processing multiple sequenced
> operations. So remove the capability to sequence multiple operations and
> reduce the maximum transfer size to 8 bytes.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-fsi.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
> index 3920cd3286d8..de359718e816 100644
> --- a/drivers/spi/spi-fsi.c
> +++ b/drivers/spi/spi-fsi.c
> @@ -26,7 +26,7 @@
>  #define SPI_FSI_BASE                   0x70000
>  #define SPI_FSI_INIT_TIMEOUT_MS                1000
>  #define SPI_FSI_MAX_XFR_SIZE           2048
> -#define SPI_FSI_MAX_XFR_SIZE_RESTRICTED        32
> +#define SPI_FSI_MAX_XFR_SIZE_RESTRICTED        8
>
>  #define SPI_FSI_ERROR                  0x0
>  #define SPI_FSI_COUNTER_CFG            0x1
> @@ -265,14 +265,12 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
>                                      struct fsi_spi_sequence *seq,
>                                      struct spi_transfer *transfer)
>  {
> -       bool docfg = false;
>         int loops;
>         int idx;
>         int rc;
>         u8 val = 0;
>         u8 len = min(transfer->len, 8U);
>         u8 rem = transfer->len % len;
> -       u64 cfg = 0ULL;
>
>         loops = transfer->len / len;
>
> @@ -292,28 +290,17 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
>                 return -EINVAL;
>         }
>
> -       if (ctx->restricted) {
> -               const int eidx = rem ? 5 : 6;
> -
> -               while (loops > 1 && idx <= eidx) {
> -                       idx = fsi_spi_sequence_add(seq, val);
> -                       loops--;
> -                       docfg = true;
> -               }
> -
> -               if (loops > 1) {
> -                       dev_warn(ctx->dev, "No sequencer slots; aborting.\n");
> -                       return -EINVAL;
> -               }
> +       if (ctx->restricted && loops > 1) {
> +               dev_warn(ctx->dev,
> +                        "Transfer too large; no branches permitted.\n");
> +               return -EINVAL;
>         }
>
>         if (loops > 1) {
> +               u64 cfg = SPI_FSI_COUNTER_CFG_LOOPS(loops - 1);
> +
>                 fsi_spi_sequence_add(seq, SPI_FSI_SEQUENCE_BRANCH(idx));
> -               docfg = true;
> -       }
>
> -       if (docfg) {
> -               cfg = SPI_FSI_COUNTER_CFG_LOOPS(loops - 1);
>                 if (transfer->rx_buf)
>                         cfg |= SPI_FSI_COUNTER_CFG_N2_RX |
>                                 SPI_FSI_COUNTER_CFG_N2_TX |
> --
> 2.27.0
>
