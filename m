Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B887B28075C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 21:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgJATDF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 1 Oct 2020 15:03:05 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:36439 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgJATDE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 15:03:04 -0400
Received: by mail-ej1-f67.google.com with SMTP id qp15so8738306ejb.3;
        Thu, 01 Oct 2020 12:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QlsQhAx8VcoMU7dV3V3+HZkVbJgpPbjjv2CFsBU0+FM=;
        b=YtApYRsP/VX55+FIl7qwgQLzMnlPtiXghfEzyxBlV7NL0JY/sGzO2dIcfuL/kS/6JZ
         mvJkHJ5cU4+9zN4HzdlXIaFIHMOps4VYrEb48/umrRj2rUA2NDYqZUfR0ynE3KH6Vn7A
         457S6qO4BpDLiNj0HeiSFAZJojm+uFwSR181QIyxTZzF3nES9yqsHBcMqp/B/+b+WyQH
         7ytj5D8nLEEdppIIXPjR9EMchUZ7CL73Kk2lux3f06Hn0S5ePOR2zqp8Qjr6zjCI+PcV
         cydHkja/CrDmkY3+er1zp5qDLkRlMyH/jvSsyre2vZ/QFA1OEWEg2oLtxj8Kd3r8uzr6
         TnXQ==
X-Gm-Message-State: AOAM533s61dFMG97UXL5gn/gtd3UhXrfhXhouw95SXh0iPqn6Ap9GOKz
        box05W3Rbxca2eKntnKIgTU=
X-Google-Smtp-Source: ABdhPJwsZ1HHAGL3BP39ZVnfdMPs0Y2DJohS6bL0m7Sdcm1Uzv9RKqktA42we/OUm8J/rSSGH4TqcA==
X-Received: by 2002:a17:906:1f43:: with SMTP id d3mr9739989ejk.395.1601578981194;
        Thu, 01 Oct 2020 12:03:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id r13sm4824687edo.48.2020.10.01.12.02.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 12:02:59 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:02:57 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 RESEND 0/9] Some fixes for spi-s3c64xx
Message-ID: <20201001190257.GA11048@kozik-lap>
References: <20201001161340.GM6715@sirena.org.uk>
 <CGME20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5@eucas1p1.samsung.com>
 <dleftjft6xg60r.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dleftjft6xg60r.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 01, 2020 at 08:23:00PM +0200, Lukasz Stelmach wrote:
> It was <2020-10-01 czw 17:13>, when Mark Brown wrote:
> > On Thu, Oct 01, 2020 at 05:21:39PM +0200, Łukasz Stelmach wrote:
> >> This is a series of fixes created during porting a device driver (these
> >> patches will be released soon too) for an SPI device to the current kernel.
> >
> > There appeared to be a number of outstanding review comments (misleading
> > commit message on patch 7, some concerns about the non-CMU case), please
> > address those.
> 
> We discussed with Tomasz Figa and Krzysztof Kozłowski off the list that
> this is practically unused. Tomasz, Krzysztof, would you be so kind to
> share the details?

That is correct. We did not provide final comments on the list so they
could be added here - in change log. This would also be an explanation
why there is a resend. Another solution would be to extend the commit #7
description - why only CMU case is covered.

About patch #7: The decision was not to correct non-CMU case because
there were not actual reports about clock rounding poblems, it would not
be trivial change and we do not have the HW to test.

Thanks Mark for looking into it.

Best regards,
Krzysztof

