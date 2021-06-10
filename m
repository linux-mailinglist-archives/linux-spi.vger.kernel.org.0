Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA63A30F9
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhFJQnf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 12:43:35 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35474 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhFJQnW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 12:43:22 -0400
Received: by mail-ot1-f48.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so326088otg.2;
        Thu, 10 Jun 2021 09:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pir5FCYsix4/dSVHwv2JiOyxIUmPMSnlnfsQPxa9KKY=;
        b=XzXsEL3cIX8pBQHV/Q/aFxgvhCvLn6TIl9Dq1PdW0QUd4PfIle9qPTSOLoZjV2A2+K
         NYOfddD33p9K/hmdJkfpXbROKVXR3mM+YuMBwaSk/DaZiCRp6c0UTlfMf2GX07HHCdJ7
         cS049xpZj6uUyGiLOnxLcwYk/5F+MWvWNUlQBZ6ElQHq/pWQAWRgQ8SjqpbkhPVM/v80
         QTHy899jmpyTh/3S8O7qqKbQut8E1UlBT3LZzRU0+3PGTrX7uWlj6hzzRc5MyHhux3VE
         WsufhQKPFWkJluKrLfg3ga15WcKuvuI/hPyjplMMDPIDwQjRiIPCH4Hme8MgYDjJ82VE
         gLmA==
X-Gm-Message-State: AOAM531xPkYfQALcfy5ayLOQYK6Y5aQPL9wSbHxpOHl1WHAAkultsfTl
        37ssO5DE94tn+/n0ZL0pKA==
X-Google-Smtp-Source: ABdhPJydlfY2zLk5rez1GGPlY+hR/S8pAHANJQwCh0+J7JPWOEpPbUAWn9zOdt1lk0I4rb09L3vocw==
X-Received: by 2002:a05:6830:2370:: with SMTP id r16mr3196190oth.188.1623343284408;
        Thu, 10 Jun 2021 09:41:24 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
        by smtp.gmail.com with ESMTPSA id w200sm638331oie.10.2021.06.10.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:41:23 -0700 (PDT)
Received: (nullmailer pid 1940399 invoked by uid 1000);
        Thu, 10 Jun 2021 16:41:20 -0000
Date:   Thu, 10 Jun 2021 11:41:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <kernel@pengutronix.de>, kernel@collabora.com,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        Ian Ray <ian.ray@ge.com>
Subject: Re: [PATCHv4 3/6] dt-bindings: misc: ge-achc: Convert to DT schema
 format
Message-ID: <20210610164120.GA1940346@robh.at.kernel.org>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
 <20210609151235.48964-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609151235.48964-4-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 09 Jun 2021 17:12:32 +0200, Sebastian Reichel wrote:
> Convert the binding to DT schema format. Also update the binding
> to fix shortcomings
> 
>  * Add "nxp,kinetis-k20" fallback compatible
>  * add programming SPI interface and reset GPIO
>  * add main clock
>  * add voltage supplies
>  * drop spi-max-frequency from required properties,
>    driver will setup max. frequency
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/misc/ge-achc.txt      | 26 --------
>  .../devicetree/bindings/misc/ge-achc.yaml     | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
