Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1620013C834
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 16:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgAOPmx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 10:42:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45664 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAOPmx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 10:42:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so15751898oie.12
        for <linux-spi@vger.kernel.org>; Wed, 15 Jan 2020 07:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUBHE4XJm85NFA8oPl1FMyCsYkpngZCS0u/hs5fFTfs=;
        b=a7ZrdS3NHR+eeHaA7429OgMNGnXfnE0wTmnudy8zSPT/YDeBLqAwf/1rADYz/05uQb
         1WbQs4Tb/sc8hFFB+Su4axS97xkUwHcLhnpLuGzZLIOXOc448asiYsgf7vj0yPADI/g1
         JcEsMTT7O1znl7kOWJc9W2/m6Uvse/s7j9l3d3BIfRcuh5YOZwJdOazRigIlO++3A61q
         JC7AmOqVhqvusj0w71JzWNZlrJJ0gyHtWc0GKTQ618YS1G87Id0YlDxKouUu2nRqWVq/
         tOW62jsPD1G6fnebXb1zTZ1BSRAGgASmSLfHh8chmqiBt53whVcJB80c8QDCtyrj2VuR
         Iwww==
X-Gm-Message-State: APjAAAUgJQbVYwQo60ReK1250Qr9SELPo2pEHh05T/Kvev3/XZDKUPZt
        nxHoEEtR9G79SM60oio8W4AM4D0=
X-Google-Smtp-Source: APXvYqzxwm5tG51CkPf+cWYFce914nJQNrMfNIt3bgIH82yz2cnTMXHvYa/Cd6MSY1zQUbNh1GD9Ag==
X-Received: by 2002:aca:1011:: with SMTP id 17mr328307oiq.72.1579102971884;
        Wed, 15 Jan 2020 07:42:51 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m68sm5747945oig.50.2020.01.15.07.42.50
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:42:51 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22093b
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:42:50 -0600
Date:   Wed, 15 Jan 2020 09:42:50 -0600
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
Subject: Re: [PATCH V2 3/7] dt-bindings: imx-ocotp: Add i.MX8MP compatible
Message-ID: <20200115154249.GA15419@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 13 Jan 2020 13:33:18 +0800, Anson Huang wrote:
> Add compatible and description for i.MX8MP.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
