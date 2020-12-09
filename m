Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7E2D4ADC
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbgLITr3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 14:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732987AbgLITrV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 14:47:21 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DBDC0613D6;
        Wed,  9 Dec 2020 11:46:41 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id m25so4739698lfc.11;
        Wed, 09 Dec 2020 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVaC63hV12Rw1I8H9pxGk4x2FCXHBuzc5/ViFTYjzNo=;
        b=t7vVvRWfDgaq990bLAwfAXUFelPyKy8E7eTN2yUvIh5vqEqHz0vvZmBRsiiej9pZIB
         G9CiM9LkslqaaDVRlo5tMzUX61p/iK4aTeCe+Tk6I6fwj5WGqe/cEvr6I1p+zdhDGND4
         1YupZGzNVJF/Wyz2NIvoAmi/mZkFp9Kj6A+H9Y1AVFbpw+Lw6gCOTI8eofPMnFj3Lh5G
         TBsVW+2H30hLXZURE2oUK1ZOSVUwrX3eZyYo8d6ARJuwYuqbD7e3CZQLfsoUi8o8GFXW
         QKNybPYedIMf4KnacGiffzC4iCZ+TT7AroH66DQwJvY4rFh4HhXV42gAMECXGZes5/6k
         oIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVaC63hV12Rw1I8H9pxGk4x2FCXHBuzc5/ViFTYjzNo=;
        b=pNEUm/s7BVTEWvDh7c7SYUqI49IwrzAPCmLrf+LCTyCcw0i7ElsVeC3Z6uXDFqHtMv
         aC5PPnqT2ViTB1iXbybrfzDA3izjljbilFPABkXjLwqduKMmsUyjLi85wo6VcmhsPzJr
         ktUWX0TQdhy3Z43SyeVGAM+oGjzLr8FpYFe2tWG7MnAhoYrlM6rlZPFbUmjIBKqqWoM6
         qQ5FtbcnO1QfDiWa3GzLp6LRUgar5+6VBBvhmBKbv+rWRU+2FUYsiXZG95lxFd33Zgka
         Cdseko3B5cyRBm7c1zeX5fdzaBqsi52OtAYdXhztATP1Q8khDgp22zLvxXvfnckOdprJ
         XsjQ==
X-Gm-Message-State: AOAM530bTGMqfYnZ9tTWE1mwId08icf9vZMCYrOQPTuYfDZb2h9JXzNY
        ELnWZIBUWckfdmxk4q5oAvU=
X-Google-Smtp-Source: ABdhPJwle6tU7mshp+KpavcomiEzTSC1GGBuXo9RFqpgmbaivSKVy4FM4zejpAoqu5UXPbrK8BPnhQ==
X-Received: by 2002:a19:4107:: with SMTP id o7mr1382316lfa.512.1607543199725;
        Wed, 09 Dec 2020 11:46:39 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id q16sm267733lfc.179.2020.12.09.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:46:38 -0800 (PST)
Date:   Wed, 9 Dec 2020 22:46:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Message-ID: <20201209194636.32f4ioxxdggezklr@mobilestation>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209173514.93328-1-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Tudor,

On Wed, Dec 09, 2020 at 07:35:14PM +0200, Tudor Ambarus wrote:
> Make sure the max_speed_hz of spi_device does not override
> the max_speed_hz of controller.

I have doubts that's right thing to do. It seems better to let
the controller driver to handle the speed clamping itself, while
to leave the SPI client device max_speed_hz field describing the
device speed capability. Moreover the SPI-transfers passed to the
controller will have a SPI-bus speed fixed in accordance with the
controller and client device capabilities anyway.
See the __spi_validate() method for details:
https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/spi/spi.c#L3570

-Sergey

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/spi/spi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index cd3c395b4e90..51d7c004fbab 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -3378,7 +3378,8 @@ int spi_setup(struct spi_device *spi)
>  	if (status)
>  		return status;
>  
> -	if (!spi->max_speed_hz)
> +	if (!spi->max_speed_hz ||
> +	    spi->max_speed_hz > spi->controller->max_speed_hz)
>  		spi->max_speed_hz = spi->controller->max_speed_hz;
>  
>  	mutex_lock(&spi->controller->io_mutex);
> -- 
> 2.25.1
> 
