Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4735C5604B6
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiF2PgB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 11:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiF2Pf7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 11:35:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C452FE72
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 08:35:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g4so17085095ybg.9
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yW0eUyCLx9NY1BpaMyboaJ9/MpwhYRH4whENi4LPOtk=;
        b=MjKA9WdmLf6bWRWBoFrRrWuYy/pWZKX9zw6M4FfYvvBchQ+XfOfIum8biHAiobRuaV
         7qbEj19dQCo4R7bhbw9yY+Ild1uJfheybOCbuTFsKh5BpP+HHGGcXv9kyFae21PBHWKj
         6ZN2f7D6TYtB4FfpKW7Bg/E6QG2TLE0WI/vM/d3utA/mYnwuNojvOsRLmUac/25Q79Bq
         VvcumEazN7LoTQwJnfcFb6fPXLNXnIrmRrWWIkNXk6xj2zqDE5OsBrTZ1bBusP8g7rcL
         RVDndbvpuR2/97uwhL42+fjEe7Xai/xTaus7n9n/UqSCZENqp4pVwJG21o87tlF1tJtl
         Wh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yW0eUyCLx9NY1BpaMyboaJ9/MpwhYRH4whENi4LPOtk=;
        b=SGSyRl+4UTnsJv4zx+7rIctgwD9OLOnpUxtGGxtKXdgo5YLTHd4o67OxuZbeGVUuPK
         q+IWadhCd+6htWlxluN6sOhss5gJ/ijXo90Pl0L/8dklw5RslqeXY0UnxRpm8KfxX+K+
         9CfT4wI3ksB3n5km1BYowf6M37exPkXQ9vjyHcjE0fSLBpelETjCWQJ/UPproAbUvgNz
         ia/9bV0JQSk8Cg92rqmZoBbseBEJ2RrVn1C4OxhpJOYkfzWcgahNrAcaFhLeGsHyGCjq
         QSGH3oR+OioblKCFjnswSt2tmk8xtEpiYPXFVbz1EtIE+OYa/G90zZ6Hqd5lzRFoStx7
         XQ7A==
X-Gm-Message-State: AJIora+Ycj46Ci+nmUa4ISbmHtBI9tYZoPSt8Tt+moZEGgFGmuzNTVtM
        70kuzXvNmGaZsDoVGMzW9GMX74s7eBHGE3bJ2gE=
X-Google-Smtp-Source: AGRyM1taASU3sYiq6P9Ailv0sKs1kG6elEq7FMhXdhj1OcJ4LnreFlYp1GXfmaV+DpLzHHr7dbL3xI30+cpxavWfSYc=
X-Received: by 2002:a25:dd83:0:b0:66c:8d8d:4f5f with SMTP id
 u125-20020a25dd83000000b0066c8d8d4f5fmr4014703ybg.79.1656516956696; Wed, 29
 Jun 2022 08:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220629120700.620108-1-jarkko.nikula@linux.intel.com>
In-Reply-To: <20220629120700.620108-1-jarkko.nikula@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 17:35:19 +0200
Message-ID: <CAHp75VdhGDR0cGt2Aky=sRRDB=u4mwxWZgQ+DGL08QZFBMKiAg@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Meteor Lake PCH-P
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ap Kamal <kamal.ap@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 29, 2022 at 2:09 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Add support for LPSS SPI on Intel Meteor Lake PCH-P. It has three
> controllers each having two chip selects.
>
> This squashes a fix from Ap, Kamal <kamal.ap@intel.com> fixing incorrect
> PCI ID of 3rd controller.

With PCH removed from the commit message (including subject)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/spi/spi-pxa2xx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index edb42d08857d..838d12e65144 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1404,6 +1404,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
>         { PCI_VDEVICE(INTEL, 0x7aab), LPSS_CNL_SSP },
>         { PCI_VDEVICE(INTEL, 0x7af9), LPSS_CNL_SSP },
>         { PCI_VDEVICE(INTEL, 0x7afb), LPSS_CNL_SSP },
> +       /* MTL-P */
> +       { PCI_VDEVICE(INTEL, 0x7e27), LPSS_CNL_SSP },
> +       { PCI_VDEVICE(INTEL, 0x7e30), LPSS_CNL_SSP },
> +       { PCI_VDEVICE(INTEL, 0x7e46), LPSS_CNL_SSP },
>         /* CNL-LP */
>         { PCI_VDEVICE(INTEL, 0x9daa), LPSS_CNL_SSP },
>         { PCI_VDEVICE(INTEL, 0x9dab), LPSS_CNL_SSP },
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
