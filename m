Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86C96C90
	for <lists+linux-spi@lfdr.de>; Wed, 21 Aug 2019 00:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfHTW5o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 18:57:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42676 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHTW5o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 18:57:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id m44so584057edd.9
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07iW9OsevzlS5I3et5+zU0iR4z/1YzAmleuCQeuJJF4=;
        b=Gwd8DHU3cBtgZ3mZfij4abNm4neUMRFcD2jq0Lo0BUiGTDK2WgUkk5fflJkFtyuXVu
         qdJ2oxCpckIWmdY9D2C7GX3yfJRFZKf4Ueoj+y7Zz7cCq9iI5W/UqB3efa4/fPo/xaF3
         NMVM6Zrgi8UovDRHhf51XThB+zFJpRD6cpTX0FJCYApm/bmhy03dKyusza4gcHL7CsBe
         vGy5KLGVT7zXZ88DWnZbOSKaSZZlBtbNxMyjXIDkPhs+RVeIxYQSiHpaQAmc+Ltoo0hd
         xAv7mjxVUVxyFCJIGCYKvR6EBXeoKgOLvZl5MswEdnpRGDE37KqlrRg7MsVhDNmrJ4y9
         42gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07iW9OsevzlS5I3et5+zU0iR4z/1YzAmleuCQeuJJF4=;
        b=L2xq6WbnXR9KBPjnKb9FuntXkDPhPm69rmc+WU3waeG35vNgiDo85yzyOgmlpAENKK
         EERFAbMLZEyHJMoIXKzfJ+2RZTlPDZSyAzW/oKjWzKHIpDHkoxNvLn+ow0F1aFGC0i8D
         sr8DUpErGzrGA7QOKH9HhU2VSeNj6+xPYjAunYbDD/d8pYpo+7XOzaL8ZvaFDymhlcWK
         LK1dGFdQ0eDblu/28ezw0NWp0YWpq42MWw9mw7oK7+chYMFZM5GQQwM+l83lzLvIbY1C
         cWioQrwK4nP8nvKgLKZnDXLQ7/LhTQ5ZJ+9/wk2eRFnuDqSS+NBMGb4O66jNZACJQSu8
         mFPA==
X-Gm-Message-State: APjAAAWKjXkGbzTdEA82hu2LC17ueF1jjFpf+NJ9wMh0r5oDcHmIOFaQ
        137LHnSL/2m7bi8ZcVXA8OlFXUUrN9SnzTz5pbo=
X-Google-Smtp-Source: APXvYqznkyXL1qoBCh3/hd2iI422dceLxLnlSIeBetpmQDzoAeHBmGrnZfuf/GaLYkvjVT0NOFP+CvFzkDMMVYAqZeA=
X-Received: by 2002:a17:906:f746:: with SMTP id jp6mr27919570ejb.32.1566341366240;
 Tue, 20 Aug 2019 15:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190818180115.31114-1-olteanv@gmail.com> <20190818180115.31114-14-olteanv@gmail.com>
 <20190820130257.GD4738@sirena.co.uk> <CA+h21hqCyJ4WQgP31gcMq21k6wG8YQmbg0BZKwh_2YKvWKY5RA@mail.gmail.com>
In-Reply-To: <CA+h21hqCyJ4WQgP31gcMq21k6wG8YQmbg0BZKwh_2YKvWKY5RA@mail.gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Wed, 21 Aug 2019 01:49:15 +0300
Message-ID: <CA+h21hoYv=a5qm4ewB7ey2K2N5Uv5Wm9G2fELX_0ukJZcdXbQQ@mail.gmail.com>
Subject: Re: [PATCH spi for-5.4 13/14] spi: spi-fsl-dspi: Reduce indentation
 level in dspi_interrupt
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 21 Aug 2019 at 01:43, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Tue, 20 Aug 2019 at 16:02, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Sun, Aug 18, 2019 at 09:01:14PM +0300, Vladimir Oltean wrote:
> > > There is no point in checking which interrupt source was triggered in
> > > SPI_SR, since only EOQ and TCFQ modes trigger interrupts anyway (see the
> > > writes to SPI_RSER). In DMA mode, the RSER is configured for RFDF_DIRS=1
> > > and TFFF_DIRS=1, aka FIFO events generate eDMA requests and not CPU
> > > interrupts.
> >
> > It's also good to check interrupt sources in case the interrupt line
> > might be shared, that means that it's possible that the interrupt
> > handler will be called when there's no interrupt at all from the IP.  It
> > also helps with robustness in case there's some system error though
> > that's (hopefully!) a lot less common.  This driver does set IRQF_SHARED
> > so it does support that, I don't know how many systems could do it but
> > it seems a shame to remove the support from the driver.
>
> Ok, I hadn't thought of that, I'll add the check back.

But shouldn't it be returning IRQ_NONE in that case? Right now it's
returning IRQ_HANDLED.
