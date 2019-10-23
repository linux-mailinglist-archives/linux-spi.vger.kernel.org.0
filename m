Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF5E1C4D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405663AbfJWNVr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 09:21:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405607AbfJWNVr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 09:21:47 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N3Kc6-1hxWBf1L2Q-010NK1; Wed, 23 Oct 2019 15:21:45 +0200
Received: by mail-qt1-f182.google.com with SMTP id w14so32187382qto.9;
        Wed, 23 Oct 2019 06:21:44 -0700 (PDT)
X-Gm-Message-State: APjAAAV4evTZkc8QvVs46EuK469NNe0FS1T629zeVTpLUL9czu/hcklm
        d/ciWCbECtxeVlWsxqAfEC3n8f1z5sfcMG6koNI=
X-Google-Smtp-Source: APXvYqwM2qEEMnGfHv8Zjb1lutdzumiJLhReXUDt54qECGm5JtGOI75fA1JAhUI8HrWZ9XEpyPDWgXHf+8DP7KS9kXc=
X-Received: by 2002:a0c:d0e1:: with SMTP id b30mr8768414qvh.197.1571836904019;
 Wed, 23 Oct 2019 06:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-13-arnd@arndb.de> <20191023123200.GC11048@pi3>
In-Reply-To: <20191023123200.GC11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:21:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2LnsqfFf4X2XrBMHBuBKZOHYQtwv4_Hj7RFC1wkPAwqQ@mail.gmail.com>
Message-ID: <CAK8P3a2LnsqfFf4X2XrBMHBuBKZOHYQtwv4_Hj7RFC1wkPAwqQ@mail.gmail.com>
Subject: Re: [PATCH 13/36] ARM: s3c: move regs-spi.h into spi driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Andi Shyti <andi@etezian.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Kc2/umFPU3EEwzXXPT72ODcqpU+joczmHFtSKx9N5mJF5DFQ12p
 vPv8kEtNG0xYf9QUQfRsVKvlRhX8lOtb2CTGBPzT8SNmbk87y8O9qqhi9v5Zbg4q+8ZzfOu
 h28JSiQqFR9Fd6pfWlIRYYJ1+ktLjB56UwKDNJaG6oKAFCIShXnnBfBKtTea196rs5ikmu7
 A+ePvMU9lAE2oPOJVP+kA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pW7bVROir+Q=:TOf6c1fpXBhnVHIBkHUqo9
 i0st8ZnEh/m3972sds/I6F1jGt2uPv7GuiYY9aOWim1Uc8Kl9HXafWjDRFmvsVVnj0Su/k8pt
 MqfJwqYo1xEz7OYH0j18csrGnPVrJWuQAgDb/0KcSNFP1lVzKMvuCsDozcCI5gC6YvXXvaLUK
 GrSx4IY3Fhh0y7PQM+uDf+R7Ek0h1vTCoHWk0zpVW9rLPjm7jTQybsvlk2E6dvI08xX5+WUJ6
 MGrx72k34cdkj71trJX+Fbi6EM/2jxiFb6LVPZNM8nmXsfEbdknpABRsmdx+2DoP+x/Bvi65W
 rzUr4rGhqfBgWpvBN/Bs4MJFJVARzk927TKjGPRz1LDNM67HpN/o0cFjo4AD+5nY+6J/mWk2a
 2HKgRWXTg10g5GwdDW8Eub8OFknhDR/LBm9lD8+CuYJBvwluf4Rl61DbylJAS2HvjqOUCSRdV
 WEZu8ROIMnhhH0X/O5hIr9ycU3MgKSC8L1H1DrhEnCWsSOVwUMHut/qoaM4x0BlswVn+KzjcG
 TkmZ9w+QmpPqycveV+vL139k/dG8DI9mFBsEwO44SRCFpypKmXJrkzvDokPp7k9UzmEQ3tNua
 XtYAAT7H3x3k/l2jSzVdIlYNS0JlAXaVgKJ5PlGUh0AyClFppTZmSn8gadtPk6N2iW4jhJcjS
 BUOz822VODCjeTUXHYc+ErdIeTlOHcPTBvjPf6CBMGWk92AGRjma6VwNPgBiPXAlj/ieFz/Ij
 x7id9jNf5GJme7GZNBQX6Yt7Vg3222RtIrR5DTTw97p9VJDcbYfM3Oyw/t+dIdAI2jKWnERug
 9xgJd2HTLFBUGebysFj33bja3OqSgc2X7WzVUZALoT3enSizPaWKs3/usfYNAY/ceO89AStgR
 p9pqdAp3ak2r4qrUoFLQ==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 23, 2019 at 2:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:57PM +0200, Arnd Bergmann wrote:

> > diff --git a/arch/arm/plat-samsung/include/plat/regs-spi.h b/drivers/spi/spi-s3c24xx-regs.h
> > similarity index 95%
> > rename from arch/arm/plat-samsung/include/plat/regs-spi.h
> > rename to drivers/spi/spi-s3c24xx-regs.h
> > index 607844311566..37b93ff7c7fe 100644
> > --- a/arch/arm/plat-samsung/include/plat/regs-spi.h
> > +++ b/drivers/spi/spi-s3c24xx-regs.h
> > @@ -8,9 +8,6 @@
> >  #ifndef __ASM_ARCH_REGS_SPI_H
> >  #define __ASM_ARCH_REGS_SPI_H
>
> Can you also update the guard name?

Ok, changed to __SPI_S3C2410_H, this seems to be the most common format
in spi drivers.

       Arnd
