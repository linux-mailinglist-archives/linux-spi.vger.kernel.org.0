Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19877399373
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhFBTZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 15:25:08 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39680 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhFBTZH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 15:25:07 -0400
Received: by mail-oi1-f180.google.com with SMTP id j1so3750550oie.6;
        Wed, 02 Jun 2021 12:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XAeJv7qZUUGdgq8G5ai3wA48HtkAvEJX/GzuCHR5O/I=;
        b=LkIrlajuQiyAXy+zGq0M8pHEFxhHvDGcKb1mID9laV4fg1ykl0VfoV8XaQWE9SKZ+O
         HhpioxjRjWjcxwxd8RH9qozTAwYW9UdAfVU/F8FsRquVn+PtQOs1/fFtP3pPBGHiu446
         R+m3xLgCuRFlGrCO/IRWcjw1RE/B3R7bR90bCv9CE/crMXN6t24kGScDx5a6JFTKSmsj
         +2D1MHWpjo7vEzCXg6yifOULR/O845McxxIF7ZogtlPwfLpTdqW35G/2RhoL7Uq6gjCx
         H5bmAdWrM5N9M+eoJZqmDLyqEbxzNFnJGF91iUH03+1lyIIH+1eU8BqhQwh94Ow3g27Q
         wo7Q==
X-Gm-Message-State: AOAM531yGfCpocSdilnDJA8lqzB1wap3yEPf24xwrC3Q4DTWPzK6uBz1
        q1rxU4BKSZuHxxX2M9nuXA==
X-Google-Smtp-Source: ABdhPJzFWhHH6ZTH6NHxgK8vQrtEvn9um2KBFsSzAS7v9gqy++YrEO587CRoDAFQCGfEuE4vLuHQ+Q==
X-Received: by 2002:aca:1a06:: with SMTP id a6mr21706779oia.95.1622661788233;
        Wed, 02 Jun 2021 12:23:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a71sm178321oib.20.2021.06.02.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:23:07 -0700 (PDT)
Received: (nullmailer pid 3822810 invoked by uid 1000);
        Wed, 02 Jun 2021 19:23:06 -0000
Date:   Wed, 2 Jun 2021 14:23:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Ian Ray <ian.ray@ge.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        kernel@collabora.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/5] spi: dt-bindings: support devices with multiple
 chipselects
Message-ID: <20210602192305.GA3822744@robh.at.kernel.org>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com>
 <20210528113346.37137-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528113346.37137-3-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 May 2021 13:33:44 +0200, Sebastian Reichel wrote:
> Add binding support for devices, that have more than one
> chip select. A typical example are SPI connected microcontroller,
> that can also be programmed over SPI like NXP Kinetis or
> chips with a configuration and a data chip select, such as
> Microchip's MRF89XA transceiver.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
