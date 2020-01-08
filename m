Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569C1133C18
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 08:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgAHHSz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 02:18:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42853 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAHHSz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jan 2020 02:18:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so1704095edv.9;
        Tue, 07 Jan 2020 23:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKWXnmuEownziCsogusMGQOoNGwVKZzBfszw0zgsjx0=;
        b=BX+qZQFvlur1CF0Fp/+1SX682NKbYnQOCq97ANL01CRu0x08M2RoXqosRQgVMJztd5
         XSxjH4IMa8iIqZYFN6jaJjWNPqZiawlrmcVXnYuLdCLgpSArbfhTbe6CrIcL4+gnt4ZK
         mSMaf2JJaBkHVurHZINur+vmzThhQW9aFxOxEshxnx9aMpbTSXu7ZUn0Hxxaq8hoQIDu
         qvbwTj7ZRFrV0Ra9ees9VNY2SuvhKT+bCMfgzN0hVqWoJz2ieO6Tozy0/Oth8mb4yn91
         fOh+Ahe5mfZpWI+y57XkDqsAioF4ABurTDSfkFQbcTAqAF0Ah6z4/X3kpQeKmgFJW8aF
         Qr2A==
X-Gm-Message-State: APjAAAWOMVUKTFYDOVHiTI4bArXBLXLsrrSZZUX05QpcqEXRe0PJh1f6
        ccezOOfS0w1AH+lFf2zPwlM=
X-Google-Smtp-Source: APXvYqyETcB+X+rnMpVlEdL61P6sw8GiQqAu/OK8GSwB7w+xHZ46OokCHRm28lJAz1v4QyehAq2P6g==
X-Received: by 2002:a17:906:cccf:: with SMTP id ot15mr3399070ejb.7.1578467933635;
        Tue, 07 Jan 2020 23:18:53 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id y11sm49909edw.73.2020.01.07.23.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 23:18:52 -0800 (PST)
Date:   Wed, 8 Jan 2020 08:18:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: sh-msiof: Do not redefine STR while compile testing
Message-ID: <20200108071850.GA9762@pi3>
References: <1578416218-11112-1-git-send-email-krzk@kernel.org>
 <CAMuHMdXZGqqu+rWmemzxYtSNXofeCwLwerCeb-hEoubTvBqwXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXZGqqu+rWmemzxYtSNXofeCwLwerCeb-hEoubTvBqwXw@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 07, 2020 at 09:10:37PM +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Tue, Jan 7, 2020 at 5:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > STR is a well-known stringify macro so it should be avoided in drivers
> > to avoid warnings like this (MIPS architecture while compile testing):
> >
> >     drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
> >      #define STR 0x40 /* Status Register */
> >     arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
> >      #define STR(x) __STR(x)
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/drivers/spi/spi-sh-msiof.c
> > +++ b/drivers/spi/spi-sh-msiof.c
> > @@ -73,7 +73,7 @@ struct sh_msiof_spi_priv {
> >  #define RSCR   0x22    /* Receive Clock Select Register (SH, A1, APE6) */
> >  #define CTR    0x28    /* Control Register */
> >  #define FCTR   0x30    /* FIFO Control Register */
> > -#define STR    0x40    /* Status Register */
> > +#define STATR  0x40    /* Status Register */
> 
> The datasheets call this register "SISTR", so I prefer to use that instead.
> Actually all registers have this "SI" ("Serial Interface"?) prefix.
> Shall I add this to my TODO-list?

I can send a v2 changing all register names there to SISTR-like names.

Best regards,
Krzysztof

