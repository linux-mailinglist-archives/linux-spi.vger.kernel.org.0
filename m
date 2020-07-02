Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DDB212916
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGBQLo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 12:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgGBQLn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 12:11:43 -0400
Received: from earth.universe (dyndsl-037-138-186-086.ewe-ip-backbone.de [37.138.186.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E1B2084C;
        Thu,  2 Jul 2020 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593706303;
        bh=/y2qX4twvgax/vSIk5ikbxnbfpuh3lgVLY3u5KycooU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixoMB58Rtg3tN/Pd6CdCLra/Hfk0I1CQgnhhdmehdmsOFQv81Dyyq+3dbJw5eWu0E
         bwEF0KHfUTLET9sHvFzCyFTLMM/T0/zvwX5amVHdshn5BVVj3gD7i/NyYzclyxa51E
         k/LKhnb3odHHKCFxylqL5KB1KHlhOVFq2B4PEiQM=
Received: by earth.universe (Postfix, from userid 1000)
        id 6DD653C08CE; Thu,  2 Jul 2020 18:11:41 +0200 (CEST)
Date:   Thu, 2 Jul 2020 18:11:41 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: Change Maintainer for some at91 drivers
Message-ID: <20200702161141.xwvwoxjph7l2tpeq@earth.universe>
References: <20200702134224.3750-1-nicolas.ferre@microchip.com>
 <20200702143909.GH4483@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702143909.GH4483@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Jul 02, 2020 at 03:39:09PM +0100, Mark Brown wrote:
> On Thu, Jul 02, 2020 at 03:42:24PM +0200, nicolas.ferre@microchip.com wrote:
> 
> > I kept these entries together as it may generate conflicts if handled
> > separately. I suggest that Mark take the chunk as maintainer of SPI and
> > Audio sub-systems.
> > Anyway, don't hesitate to tell me if I should handle this change
> > differently or at another time during the development cycle.
> 
> That works for me (though I'd be a bit surprised if it generated
> conflicts), Sebastian?

Also works for me.

-- Sebastian
