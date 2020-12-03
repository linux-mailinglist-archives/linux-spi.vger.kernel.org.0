Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40D2CD913
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgLCO1T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 09:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgLCO1S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 09:27:18 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE2C061A4E;
        Thu,  3 Dec 2020 06:26:38 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so1223854plr.9;
        Thu, 03 Dec 2020 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmlHNhnBbpal8IKytHTdYXXzg8wBb8EaRJxXyVenTR0=;
        b=quvplfd5ZaoQvtY3zNBqQ/XoGCTzAr5Oj0JZVRPiO2ecBtg65KC0b85Hk8N8Z/7BkR
         /gAgww4LRd2aRaz79gRiGjy+QhMtjrBHYuFxEuw6kh3gEiyP9I10+09BiTkFmE8QuMIy
         4/cib1pMzBU8V0W2GnZNQoqtGiCdCnkuAJkQGwCwXfvdlKYI0eanBes8WhVW1B6Ylbwe
         Oo9Y2vbAg6aQO+nhvhDTewXicRkz9oYpvkoyJu6FlqtbQ1MmWDgm0v6aSnv65Ea3Mqi1
         4ry6UGO05dIdqUZ92/yT0nVlKtUrDI/13cyDFCgVmgvZr5wn8Jxs9Yz/zrTSGlYjiEor
         nFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmlHNhnBbpal8IKytHTdYXXzg8wBb8EaRJxXyVenTR0=;
        b=lIi1cqBNW3ydqNSYhguD1UsnFyYxQxIc305uHovx7KAFOik+g7rRt2Sd49BApwVDOm
         xtU1cKtZCXsPRvW5ELVMUf0vFplhwXN0WJju5uuxHsg2F3ESrkg/8EUkUaohKOCqJieU
         JFeXe9R2iTHHIG9Gq8tr81P7yBXbt74tkRNpIg1l9L/YySqvkJ6B5nLRCmTvWQfkw9FA
         c1SSB6eaQEOS3kXGQZpR6CyLvH0770m0OBA3N9Creu1qm3DJcVpy+4HDifna6fc+Kxn4
         QAIBIIoNoVmBppTBawv7JHn5gmrPnckO9XpGBBgmR7a2mL1+9MnJMBwe8Af7KCubyMPj
         45JA==
X-Gm-Message-State: AOAM530RBMbA7dV0r5sON+Ie68Ujn9okpk178HqEX+4CJjl74tpUhfpF
        n4wiQRY1d3RKlMcLnHv4+WPIbE4Btr8p2vMVNz0=
X-Google-Smtp-Source: ABdhPJyofuZKZKO5K9Ewu29CW/v+Ah+wyMiFoHzE1a88AA44BaG/yo9Ng8IqRPR5gdc2rcFnKBU/HYTj9REuQzurF9s=
X-Received: by 2002:a17:902:b7c3:b029:da:76bc:2aa9 with SMTP id
 v3-20020a170902b7c3b02900da76bc2aa9mr3329660plz.21.1607005598115; Thu, 03 Dec
 2020 06:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20201203140531.74470-1-alexandru.ardelean@analog.com>
 <20201203140531.74470-2-alexandru.ardelean@analog.com> <CAHp75Veh=b0JYOP_gETyqqGGEYhO9JcxFCGXSuzSX27-qioprA@mail.gmail.com>
In-Reply-To: <CAHp75Veh=b0JYOP_gETyqqGGEYhO9JcxFCGXSuzSX27-qioprA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Dec 2020 16:27:26 +0200
Message-ID: <CAHp75Vd-23R0EeXLMFBqsxy4HzC2huGYPJm6LX6r1==bh5xg2A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] spi: Add SPI_NO_TX/RX support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 3, 2020 at 4:10 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Dec 3, 2020 at 4:00 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:

> > +#define SPI_NO_TX      BIT(31)         /* no transmit wire */
> > +#define SPI_NO_RX      BIT(30)         /* no receive wire */
> > +#define SPI_MODE_KERNEL_MASK   (SPI_NO_TX | SPI_NO_RX)
>
> This needs a comment to explain what's going on with the flags (split).

...and to be consistent with proposal in uAPI:

#define SPI_MODE_KERNEL_MASK   (~(BIT(30) - 1))

-- 
With Best Regards,
Andy Shevchenko
