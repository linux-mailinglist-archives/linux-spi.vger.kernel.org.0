Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57DB45774
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jun 2019 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfFNI2U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jun 2019 04:28:20 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:40382 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfFNI2U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jun 2019 04:28:20 -0400
Received: by mail-pf1-f171.google.com with SMTP id p184so985357pfp.7
        for <linux-spi@vger.kernel.org>; Fri, 14 Jun 2019 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p2FqfFq0yn9yeJ0J+4e9XoKb8WwDvat+ZSRymdM/JSs=;
        b=Pt2tM9L+b5exMbM1gOL27KLiCOZKF+5LpwfKM2CbqGoUih5Q4MVgtpY7BjsZZcEmGv
         laYSO+fR7yVcuVzq4MKijbCJHZcJr9qjk4Rjc0p/BucDx3QgZ1FaKPzL+BerHvPIeVD2
         o/6SLGCfCsfjD4QYIdhMlM72POJLIyNFCuO2CyGu7YlzVFHA7xIO89vVeVcae+3NgZat
         nxRyZ8iWe/zCwG0+1kAiO7A73pbcTqY0ePDcgnA45RkM6euTfqw7mmG6wDOsC7PBvk7z
         MKpZKxxYiZRtuq+deQsbN7CYVYoY+NekqHbcPQjhvMjqMib/lGs+xLN4cCn/6vgAi2z9
         jAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p2FqfFq0yn9yeJ0J+4e9XoKb8WwDvat+ZSRymdM/JSs=;
        b=ZQ7U1j05e7VdWd8zPK/deefA7eeIOIbs6WZ36A1GTW7av12321M9dLAzYXokoMLOBf
         MXgxAVINSW+9SKS6tPEz9ILPCh7neRLW8uxrVJ0q+Wvq7YXcNP08bJ3DTkM33uBJ8tUS
         x8HAuo5hcCocjDSv+g3ulpRq05KhJf5zJx0uJDoW76FKhXae2Lcv1xFvOskJChM3twMD
         t3c8wjkkoyTi4d1CKlrfhwTIOAd0Nssg0VEqSy6i/8ogCQXdtmjJ0Y1A4Bw32MFKyxSx
         drdcCY9XH2Meu96xOXDCSmbMJN9vImSyp8cepO5foc+IXdixgO0kNB0rnypQV4B6RpJ6
         XJDw==
X-Gm-Message-State: APjAAAXC2QPNclRuj2nCrsvfbso97wuHWe0EL5SO8lbvTWyU39ZMbTX7
        2cG4AEqTJjdR9eiWo2nevWBXAsAHMtUMCVCE5Dg=
X-Google-Smtp-Source: APXvYqxom3R3Af+LuMAxXajxTrk6qOc0qyg8RPUgFl4UDv6QxHZ+s7vquQjHp1vJk3CgKzGSAoathsKqAjJMp+KuYBE=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr10097070pjb.132.1560500899614;
 Fri, 14 Jun 2019 01:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
 <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de> <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
In-Reply-To: <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Jun 2019 11:28:09 +0300
Message-ID: <CAHp75VdhfYXa_6wkYD+_DYQh1k5Mc43e6yF4uj00e6EvgGuOHg@mail.gmail.com>
Subject: Re: SPI regression with today's build
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 8, 2019 at 9:27 PM Noralf Tr=C3=B8nnes <noralf@tronnes.org> wro=
te:
> [cc:Martin]
> Den 08.05.2019 19.07, skrev Nicolas Saenz Julienne:

> Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
> suggestions, I think we should just revert this patch.

I gave a suggestion during LPC 2016 about this all stuff. We have to
provide a DMA channel capability to tell user what is the maximum
length is supported by the DMA engine. In such case the user may
prepare the transfers which are satisfying limitations and no
recreation is necessary, moreover, it will be performance wise to do
so.

--=20
With Best Regards,
Andy Shevchenko
