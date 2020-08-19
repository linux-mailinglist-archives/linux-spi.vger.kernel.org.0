Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628AF249E75
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgHSMpU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 19 Aug 2020 08:45:20 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41142 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgHSMoo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:44:44 -0400
Received: by mail-ej1-f65.google.com with SMTP id t10so26112313ejs.8;
        Wed, 19 Aug 2020 05:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aPPgbu/rd3EiFTTjtdudAYmisDZ+EmrGZ1/2YVbuiwA=;
        b=jaxhdW3yvClC/pygDWYKIYnWwqTxgR6BAxsqctCQP5F5tko3d0qUc6wjZkDJMVNUve
         4pW+TvSSQh0JXlLK1lgYdYlP0EpTnkAn/d+VLAH3IEfjZmv/S9f8NkP/A8UtOOQSRfYt
         aDO2Ae+jtvqBTU4BMLVprosSjHb4MBXLq1GmjQ05ByGW8kYXsVwuxMvOTQwbwVMxisDW
         /8XAUvDo1sEVAhhBFGX86WYrqp/EkjPpJiCYFuCotNpRDr79sFbYhyid5zIZGAj4qJQu
         F5b04YzN3k4l29aybeM1sztBQDC44w3fDWiYkSld83k6KEIYlEBmwRQQ4Yt+htOo0htm
         P8FA==
X-Gm-Message-State: AOAM531ILu+E2WySSoF5hKZswwzL5TpGl3bTbAAixIH2sLgfDzqn5lka
        nMOtYzmdWXH+YJWs43Vf7qk=
X-Google-Smtp-Source: ABdhPJxKj5N6s/QhQ3Vc+HVbX0Y3A5UqWe+HM72lOucq+88giukbuy1VOTuhlK3IzB3Lu4HfALHkqw==
X-Received: by 2002:a17:906:e58:: with SMTP id q24mr19262893eji.516.1597841082137;
        Wed, 19 Aug 2020 05:44:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id ch24sm18820225ejb.7.2020.08.19.05.44.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 05:44:41 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:44:39 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 4/8] spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to
 S3C64XX_SPI_CS_*
Message-ID: <20200819124439.GE18122@kozik-lap>
References: <20200819123208.12337-1-l.stelmach@samsung.com>
 <CGME20200819123227eucas1p1f56cc06dc6c368abf2d3952ba04f37e2@eucas1p1.samsung.com>
 <20200819123208.12337-5-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200819123208.12337-5-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 19, 2020 at 02:32:04PM +0200, Łukasz Stelmach wrote:
> Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_* to match documentation.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
