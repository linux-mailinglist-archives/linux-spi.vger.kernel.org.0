Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEB2812C5
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbgJBMcA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 2 Oct 2020 08:32:00 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38847 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBMb7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:31:59 -0400
Received: by mail-ej1-f66.google.com with SMTP id ce10so1725670ejc.5;
        Fri, 02 Oct 2020 05:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ruty7DVy+OZPgSY4H/PWNx+35iqlcL+AUfsjOvXskTs=;
        b=bCidhWP34d7hMNiuycxC4287P50KNdhUGOpcSVSh8X3Y17my6Oqo2/kyG8WjruGyrF
         Lm+TXvzaCphpGV1DF9R1x66vNB9h67zBPB+RB72Sr3KNTFL8KvWL5sOu2nJE79BqFB05
         gBpW0Hm9nR7q3UQuNH0+XSq7wdjpdIVDORyZ2soCYm0dYePfFWHCUrpTOtdPit6kewjB
         e0LwG9wUrxzlFeas9mnMOG9GKsD7JOQx9F8pbaoqrKD1gFffSfYFC98oahTvyT8bGkxh
         msaBQ5pS8RB9RD+5goykYKZqcoPyKMv8m8HeIutN9co3STxYosnwmsOK5G5FHabXl6vC
         OPYA==
X-Gm-Message-State: AOAM533mqHZKRCTMcghRzpGgTAvAN9+sYGYXA0CRTVxhFL08lF+I95JX
        s9zTmRslrvUAzoJ9paSUWLk7xH3Vd+Q=
X-Google-Smtp-Source: ABdhPJyhM3dwv7SEyAI4chEDpCbHJ/cxuWy1xtuG8hiRd28Nc8mdupnHvxGqdM5WftW4lVi38BAeFQ==
X-Received: by 2002:a17:906:37c6:: with SMTP id o6mr2118364ejc.404.1601641917025;
        Fri, 02 Oct 2020 05:31:57 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id a22sm1039191ejt.65.2020.10.02.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 05:31:55 -0700 (PDT)
Date:   Fri, 2 Oct 2020 14:31:53 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Message-ID: <20201002123153.GA7463@pi3>
References: <20201002122243.26849-1-l.stelmach@samsung.com>
 <CGME20201002122255eucas1p21976a8ba0566564b79a9dd6f62cd4caf@eucas1p2.samsung.com>
 <20201002122243.26849-8-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201002122243.26849-8-l.stelmach@samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 02:22:41PM +0200, Łukasz Stelmach wrote:
> Make sure the cur_speed value used in s3c64xx_enable_datapath()
> to configure DMA channel and in s3c64xx_wait_for_*() to calculate the
> transfer timeout is set to the actual value of (half) the clock speed.
> 
> Don't change non-CMU case, because no frequency calculation errors have
> been reported.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

For the future, tags are added in chronological order, so first is
suggested (as someone suggested to make a patch), then your SoB (as you
wrote it) and then my review (because you had to write a patch before I
could review).

All other patches here have these mixed up. No need to resend, but keep
it in mind for the future.

Best regards,
Krzysztof

