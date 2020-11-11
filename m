Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F882AE505
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 01:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKKAnm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 19:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgKKAnk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Nov 2020 19:43:40 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BE0C0613D1;
        Tue, 10 Nov 2020 16:43:38 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id b11so123804qvr.9;
        Tue, 10 Nov 2020 16:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=te32oWHsYf0/wGLDWEI6cIibT/+xmHk3vK5gsEaTJAE=;
        b=Wh/1MusAFQr1P+adqfyA+GYD7VTCLGKwroma4jrLWO4bKZDVPWwPPaTcCmv57qRTDL
         T53+mUwexHTysyi5ganvZXdKGQHF3lU0zJTMDda6725pSeSMzzoiLzFaw6J7zr41DYWj
         7noNgjLBb5huieK1rcPGJvyjDutXL7O+h+gVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=te32oWHsYf0/wGLDWEI6cIibT/+xmHk3vK5gsEaTJAE=;
        b=MQ+ji9pRDuJvYVKh5IeP51KgdWRZpyl3zwPTM5cT7FJSlZYFvA5IYlVkPDqb2qY3kX
         AbImDHAOObTZwzN1RKe6iZVsQoySqJTDXUWQOdhcnI1OxSEwcjicTHpJLSAvqpO2JEtJ
         vX/tLtEWXd8P7v9rx2q0n44Yus0iUgHKG6GdeU3NPVafXjAwJkPh9PK0LSZqY3J29qy6
         oZLMj4QIw6Mj8NYGkO+tHZW7QZv/4lNUDSuSTM/3HZJoLXssMDHSMh4xi/R+H1glzD5v
         eVDdzhnw57cCrfdYsMIaQydRKFdLyQB+peBlvOllM2V5Hd+WSSgNL0IrjYS5jJcFXSg/
         +7AA==
X-Gm-Message-State: AOAM5310kVKksoR5RP+2GX6xzH8Cpc21GRTklz8XxAJUsILsUwwa9lsZ
        xrXyKKa3tFovGMuDJx11bToj0X9sEu/u40WW+So=
X-Google-Smtp-Source: ABdhPJxwSR8jaL2QblXNkRiGuqX6BzhLqsEEFBqEJ4jzOyA/LlxG2dPKvFfXqc04nuaPz1WCZpERZqP6TCIzq43Jytg=
X-Received: by 2002:ad4:5387:: with SMTP id i7mr21854679qvv.43.1605055417808;
 Tue, 10 Nov 2020 16:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20201110214736.25718-1-eajames@linux.ibm.com>
In-Reply-To: <20201110214736.25718-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Nov 2020 00:43:25 +0000
Message-ID: <CACPK8XdUs9o-F5Ap0Y-w287yocXnS64LKe=MHxGZjOZuA=7-uA@mail.gmail.com>
Subject: Re: [PATCH] spi: fsi: Fix transfer returning without finalizing message
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Nov 2020 at 21:47, Eddie James <eajames@linux.ibm.com> wrote:
>
> In the case that the SPI mux isn't set, the transfer_one_message
> function returns without finalizing the message. This means that
> the transfer never completes, resulting in hung tasks and an
> eventual kernel panic. Fix it by finalizing the transfer in this
> case.
>
> Fixes: 9211a441e606 ("spi: fsi: Check mux status before transfers")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-fsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
> index 8a440c7078ef..3920cd3286d8 100644
> --- a/drivers/spi/spi-fsi.c
> +++ b/drivers/spi/spi-fsi.c
> @@ -477,7 +477,7 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
>
>         rc = fsi_spi_check_mux(ctx->fsi, ctx->dev);
>         if (rc)
> -               return rc;
> +               goto error;
>
>         list_for_each_entry(transfer, &mesg->transfers, transfer_list) {
>                 struct fsi_spi_sequence seq;
> --
> 2.26.2
>
