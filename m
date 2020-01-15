Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E779913C8B9
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 17:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAOQF2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 11:05:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37914 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgAOQF2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 11:05:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so15847942oii.5
        for <linux-spi@vger.kernel.org>; Wed, 15 Jan 2020 08:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ89QzBAoQ2DzrvbjynM5ltUEoPFqx0Q/mdX+QC5z3Y=;
        b=FYgqVnlmMFjLY4VEFY927ZPzy7/Y4hJd/7/Atq36nx3MXnbcZrEoic+oY/BZjbyGmY
         /hkjGKLcOYA4TwikAzII0FfctoTrlUsOpHxfrjuM2vQzkPhTifpvtfx91oFZgQgd0uPr
         aHIxRwR2DFCG6PYV30rc36BFGwdO85zCD6IEAXR0fWAjLvCek1PwIkbUtzOjCpfmkJKL
         OMLCgw3SIsXDFbY+2mcldDGlx7UuXr/BPWhWdPxPAFV/4kp9ZnqplN4BA5qkys9K2VU1
         WhMiynyZt3WIFFBnz5DOoJ4Ttxn2Z2SXFeTiWrwixASKzjJOMdoJ2aKZ4G7q7jaD54Bb
         swsw==
X-Gm-Message-State: APjAAAVZQatgURPmEUFL/E96tvVYacmJlqOoyaMLPdIVxSPBAOyTu4YD
        OENlvWo13YNLWWlbe5UwhlnIQb8=
X-Google-Smtp-Source: APXvYqySJ0R5r7Dzwbg7UaxuSAHGZfRuAIPrPGvM/xg3ELhvvUTSIMmhEahEquw3DIhQOJ8YTC9HRQ==
X-Received: by 2002:aca:3f54:: with SMTP id m81mr348935oia.73.1579104327287;
        Wed, 15 Jan 2020 08:05:27 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm6670727otj.59.2020.01.15.08.05.26
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:05:26 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22061a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:42:40 -0600
Date:   Wed, 15 Jan 2020 09:42:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP
 compatible string
Message-ID: <20200115154240.GA15071@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Jan 2020 13:33:17 +0800, Anson Huang wrote:
> Add compatible string for imx8mp
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
