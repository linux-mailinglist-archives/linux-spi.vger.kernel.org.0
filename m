Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2750C9EF69
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2019 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfH0PuI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Aug 2019 11:50:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42151 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0PuI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Aug 2019 11:50:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so19113568ota.9;
        Tue, 27 Aug 2019 08:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qYug+8A/OHB6xQ/Ambyfj+28FmEVXD07tPk7WO6HC3Y=;
        b=Kf5LxI3IoXvREjjgXrfbR5kPTGN9hKsTJRrQJAtT0j59m83wMzylY/PD500IHduPt/
         gPVyu7hOSeZnjEm2ZIccMrP/YBrTM/b1zpSKy3BTmnMS9AkcL5eJ3gvSkjIzVWYJP3MW
         J0HOuSkmBPAn98RPJ6oVt3dEbvPTkUPJzqPJPJvXLnF0PT70qHYLYRcKTt/6ICp34FoJ
         qRJlQcuVwYYRGA+hc7sVTcldtBSHGv/whVMNdNEU8rJ1kowCiEMIrHhCLQq1RKBC4Asj
         ng4tfuRhk1UkvreSFSArU45wgJLHL69VLgdEmMx0Jqv6yFASsSbvXmki8dRyJT6CgyZH
         /kAw==
X-Gm-Message-State: APjAAAUbgsbD2KSPnedMwgQiZ9qNeRTOm87KyS4UsvXfbagX7l7jqRH/
        w8REN4SEZ06UnvUbGKoPrg==
X-Google-Smtp-Source: APXvYqyQsr3HFBe8hthN1uJ3CQ2iXfwZPpOybLyrFsnNasFsgN+n7AhakqmuQnHfxjBkmOE1nELixg==
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr20904237otn.171.1566921006959;
        Tue, 27 Aug 2019 08:50:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm5137067otr.3.2019.08.27.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:50:06 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:50:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Message-ID: <20190827155005.GA18581@bogus>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822184927.GH23391@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 22, 2019 at 07:49:27PM +0100, Mark Brown wrote:
> On Thu, Aug 22, 2019 at 06:39:18AM +0000, Ashish Kumar wrote:
> 
> > > > Please use subject lines matching the style for the subsystem.  This
> > > > makes it easier for people to identify relevant patches.
> > Hi Mark,
> 
> > After looking at some patch in Documentation/devicetree/bindings/spi/
> > I think I should update subject line to
> > dt-bindings: spi: Add ls2080-qspi compatible string for FSL QSPI driver
> > or 
> > doc: qspi: Add ls2080-qspi compatible to DT bindings for FSL QSPI driver
> 
> Drop the dt-bindings:.

If you do 'git log --oneline Documentation/devicetree/bindings/' you'll 
notice that SPI and ASoC are the oddballs now. I don't really care
except it does add to tribal knowledge needed regarding maintainers' 
requirements.

Rob
