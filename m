Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7CF994A
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 20:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKLTDd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 14:03:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLTDd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 14:03:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so1723311pfd.3;
        Tue, 12 Nov 2019 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5NNf6zdVT6mP8Um+2RYbDsAkGh7WYrFJZpmTUvbeT/k=;
        b=GLqqpAeopH3E+ejZdaWis3YyjkkX3qOMeutfBnD7CofrAQD7KMVjptgwv1z1ZdfOst
         b+t/J6edk1gf5Onsu4b2T+oCe/MqwSHhSMjT+XcC9HlmztIFQu9yteXGBrgm2KwULpH6
         HL3vH0FLZze4bwWtBEOxk2i8HcspOAeGXIBpqYzcMQxBo9gue2kSTCgzsLHTOHcJWrnI
         ggf5B8AepwwHrwIXKdTAFYZnWF7c/QkpLp8W1+O0+L6orQ/qXki8xXbOZ+tzGws3kEng
         l/XacGyKurR8Q17PAKtY+voM5gL9paU7d49ReJsUe2jctq/Bh+qQdXc+r6LFwKzdCGRK
         ePrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5NNf6zdVT6mP8Um+2RYbDsAkGh7WYrFJZpmTUvbeT/k=;
        b=rCJCAt9FSGmMidEFQxPz3wVNouAIzUasY3FE8j1dLr/j5dxbjJnDuafSe84fhyxRFK
         U2nf2qUvXC28kqd98DWYrle8WldweVWDDOYVkjtE3NjgtRTqS7bP24QqmdNb9OGqmt43
         lC+lX8BzpolTcAJq3DoHj6T6we3d7V9vmC7U6MhJwfEB9hRj/m+sNtlAUmDUYNx3IIow
         WibH+L7AQmZg9JEbFCvK4HujsaIYHEqd/ho9u5/x6xp3AC+wYytqej/6g431PcVFMazy
         X65IrtxIIcObIPxrB+9FgnPYYwn1Fc5lxfLlBHON2CMRpHDIeo1aAMOllgUBVwFX3CLu
         7BYQ==
X-Gm-Message-State: APjAAAXkx+ZC70Lszye323jWrWJbkUJrl7BcTWk0Zx1hI6U3wjGzjZpu
        p26PnHXbVB+UjMcPFvdUW2A=
X-Google-Smtp-Source: APXvYqyh7XFBVz7TZ5S+fL8LIywhf+W6Le4Pt2PHuj4UZVu0JCasmMizfUOmaxkz/gY/O/7kC6D6YQ==
X-Received: by 2002:a63:4501:: with SMTP id s1mr36796538pga.5.1573585411920;
        Tue, 12 Nov 2019 11:03:31 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n72sm3341657pjc.4.2019.11.12.11.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:03:31 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:03:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Message-ID: <20191112190328.GA199853@dtor-ws>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112120307.GB5195@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:
> 
> > +      interrupts:
> > +        items:
> > +          - description: main interrupt (attention) line.
> > +          - description: dedicated wakeup interrupt.
> > +        minItems: 1 # The wakeup interrupt is optional.
> > +        description:
> > +          Specifies interrupt lines a device is connected to. Typically a
> > +          device is wired to a single interrupt line that is used as
> > +          "attention" signal and also to wake up system when device is
> > +          set up as wakeup source. However on some systems a dedicated
> > +          wakeup line might be used.
> 
> > +      interrupt-names:
> > +        items:
> > +          - const: irq
> > +          - const: wakeup
> > +        minItems: 1
> 
> How will this interact with a SPI device that defines interrupts at the
> device level, possibly more than one of them?  Especially if the device
> has its own idea what the interrupts should be called.

My understanding that individual drivers should be able to override
whatever the default behavior core has configured, and the device can
establish their own mapping. We have this in I2C and I believe this
works well.

Is the concern about the device tree scheme or SPI core handling?

Thanks.

-- 
Dmitry
