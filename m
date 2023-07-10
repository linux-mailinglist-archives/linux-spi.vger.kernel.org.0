Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087DF74D466
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jul 2023 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGJLTz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jul 2023 07:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGJLTy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jul 2023 07:19:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A63ADE;
        Mon, 10 Jul 2023 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688987994; x=1720523994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h3akaffE4c4ikxI/bpe287xBwIcWxxQpigcUNq0Wefs=;
  b=kKjkc0pJadGT2DdPvJepMciV4XE5Y577eb9LvTp//t2BSQVIPf0TKsm4
   jypJWvKoJDRpvvL/LODxi+HQJBnSx2pKRpBlWW0NKTsDEw1KlCaVyfnuG
   Ac8bmzbOrzNdOZP7hzbs3SrGTMysqfQaQ4HIQp9sSX0tNd9HH+pW0P+qa
   fDWlh4yqXiTT7NVc3nPGGKmqchXNxbgW+v2G7TDD2wsBa6pj93swR2rGl
   kcv6Y+l296CMGM0HS3u/2cyeuxRm34eJzodOe55g/MwwWKMSMrlIKgUT/
   dpRzn+RPAe8koIA2BaOO9qj1D8HePBRRIQWsk1cTzzf1637V725GEdi1O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="343910841"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="343910841"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 04:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="720666509"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720666509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 04:19:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qIovf-001XRG-1b;
        Mon, 10 Jul 2023 14:19:43 +0300
Date:   Mon, 10 Jul 2023 14:19:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedts.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 4/8] spi: Get rid of old SPI_MASTER_NO_.X and
 SPI_MASTER_MUST_.X
Message-ID: <ZKvpT9M5B8QmyGo+@smile.fi.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
 <bb3b9ef2-0a32-4f8a-8d92-06d47875b562@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3b9ef2-0a32-4f8a-8d92-06d47875b562@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 10, 2023 at 12:10:03PM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 02:08:00PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 10, 2023 at 12:04:35PM +0100, Mark Brown wrote:
> > > On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:
> > > 
> > > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > > and kill the not used anymore definitions.
> 
> > > The above is not what this change does:
> 
> > How to improve it? I was sure that the form of "converting to something and
> > something" is clear...
> 
> > > > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
> 
> The change here is not the change that is described above.

Okay, than you for elaboration and review. With the assumed split it should be
addressed. Besides that, should I resend the entire series or only this one?

-- 
With Best Regards,
Andy Shevchenko


