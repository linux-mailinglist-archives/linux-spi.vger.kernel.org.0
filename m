Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E0A18AB14
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 04:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCSDTg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 23:19:36 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42755 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDTg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 23:19:36 -0400
Received: by mail-il1-f196.google.com with SMTP id p2so887046ile.9;
        Wed, 18 Mar 2020 20:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9b3Uen4TKgqfZYrJaC1MPXjmfmbCASsF1lbGTm/W6I=;
        b=H/cqjNEwHRsClQF2+0ufVnUDfZEJG73s+tJRBEfp6NjJp6ZjMynyFD0vJkxBG3PINU
         BdnK3Bst1v3ctyYXJIuSsIyuRuhax5ZWoTlocEPiw596TPkS9gjq4YBeDYwtWTISvYFE
         OMJNGusdzqTVMPteojHENnjyrSZa8GYdzFlX1+F8k+W+flAYpjTLRIKRxP8CqQemGusK
         udaDV9QgzSIQZX3sz3OPUFpNYGK4e5upcmv/nZ+7G4eCyaqjyHP8WpKoMDIg/9uuiw0f
         ghh5v9VeS/1h5w9rVGpwVzxWulV1vrZE5ZdaRZQdENvlLmgMQ5e0lLIV5a8TppcttVSK
         wEQA==
X-Gm-Message-State: ANhLgQ2d00ZxQUdiZs4/OIVWR0pVd1QAG3AWCU+LJUif0dbQaRfGRiki
        rozLFttJtEfq1cD6q7rteQ==
X-Google-Smtp-Source: ADFU+vs9QKc42qrzBiOiCiUfMsqT/P6DVJLovLlzzKYtkp5n9BApkIjgYy0mbvSQRY/2NI4n72pO0w==
X-Received: by 2002:a92:d843:: with SMTP id h3mr1205216ilq.246.1584587974813;
        Wed, 18 Mar 2020 20:19:34 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s25sm341377ilb.37.2020.03.18.20.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:19:33 -0700 (PDT)
Received: (nullmailer pid 22933 invoked by uid 1000);
        Thu, 19 Mar 2020 03:19:29 -0000
Date:   Wed, 18 Mar 2020 21:19:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: Re: [PATCH v1 31/36] dt-bindings: display: convert sharp,lq101r1sx01
 to DT Schema
Message-ID: <20200319031929.GJ29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-32-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-32-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:44:11PM +0100, Sam Ravnborg wrote:
> This bindings describes a panel with a secondary channel.
> 
> A few of the properties are only required for the
> main (non-secondary) node.
> This is properly described in the binding.
> 
> A few properties are only valid for the main node,
> this is not described in the binding.
> I failed to find a way to describe it.

if:
  required:
    - link2
then:
  not:
    required:
      - power-supply

Test that though as sometimes I still write crap for json-schema.

Rob
