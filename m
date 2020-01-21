Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABE144816
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2020 00:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAUXNz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jan 2020 18:13:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39161 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXNy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jan 2020 18:13:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so4331079oih.6;
        Tue, 21 Jan 2020 15:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yoe9RCA76HbcFOdQvkXisQfr/vhkA3pWkuRzb90Sz2E=;
        b=pjQSZALPDL8K7gYo2GU3+CfP5Hlnc/rpE1iZAwBbrCr7fb0CaQ+avgVneBzam9nJFX
         P4ON2zxUlmbV6nH4hhtIxHy/Ismp+0eWK+TUtfy3UQjwUKpHfNRiBAGkhNUeV9PtR3Yv
         jUGO4LDgcpMk4zkWioNZHwSdE1sS8H9UA17klZUyqCpQsvvZ3BDh4LjohybWMYWAhQpe
         DaedAoEFI6V9iobvrvfti0rEQ/3eb3WhclnXCVXv19Vkr9jZlzr4VNny+jbbikw6nD4b
         fncC81MYeBHlMfkH112gkbFWkDZiS6YvdO+PJDJiEujFASpTkuJEGt+M4StwtEME+dng
         HctA==
X-Gm-Message-State: APjAAAX6ryX8tYBN8BsrpsHSDYGhFqmnXQlTkHfYsGzoXUHeGG3CKvK7
        y51x+1xgi/nTO6/uYWzlNQ==
X-Google-Smtp-Source: APXvYqyMUTxp4+ieA6YgbtAvJpjT4mngt+/qpQ1WR/3sJEY3T7+Jz5uSsa6kIeckZ1T36zeCXr4HUg==
X-Received: by 2002:a05:6808:9b4:: with SMTP id e20mr4581998oig.37.1579648433821;
        Tue, 21 Jan 2020 15:13:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f3sm13968302otl.38.2020.01.21.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:13:53 -0800 (PST)
Received: (nullmailer pid 18478 invoked by uid 1000);
        Tue, 21 Jan 2020 23:13:52 -0000
Date:   Tue, 21 Jan 2020 17:13:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v1 3/4] dt-binding: spi: add NPCM PSPI reset binding
Message-ID: <20200121231352.GA18418@bogus>
References: <20200115162301.235926-1-tmaimon77@gmail.com>
 <20200115162301.235926-4-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115162301.235926-4-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Jan 2020 18:23:00 +0200, Tomer Maimon wrote:
> Add NPCM Peripheral SPI reset binding documentation,
> Removing unnecessary aliases use.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt    | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
