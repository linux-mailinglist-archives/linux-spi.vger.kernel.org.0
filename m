Return-Path: <linux-spi+bounces-3675-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73191C52B
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 19:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BAE1C221A0
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E31C232C;
	Fri, 28 Jun 2024 17:47:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7E1860
	for <linux-spi@vger.kernel.org>; Fri, 28 Jun 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596875; cv=none; b=nEpDo/FrlL50OHaBZBfeh6RZ3yF8fbPAtE1z+swejOTWzXoiiwcnVq3FpgPHAsVY5/PhOnaYtElJq/BPhXgilEdac7KlVgqGx7Rax9D57JI/HbbAd6yVlSMPbQa8p+OI4ydcvqYVDZzqt6xh0ryfgOn4M5BRzdq2Wi0b327n3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596875; c=relaxed/simple;
	bh=b91UJhEXazJSHUnlwptiBIvyT5W7DM49fVDCYOX24wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmPWcSTKsNKvrI7hLRORydW5ZOUGtwQbtk1Lotuh0plnJjloojIJ/j98AUrau2EEFm94IgXuCpKGQvUp69INwQsedhn2iunCESzm4i5lgMSd2sMhjzOgioDecxwRZp8C8lQQS+KxSgsyWo7+q+TH0citg0AQZSu7Jjwpq2HQ8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sNFgs-000855-Am; Fri, 28 Jun 2024 19:47:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sNFgn-005eiE-2P; Fri, 28 Jun 2024 19:47:13 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sNFgm-002WFp-39;
	Fri, 28 Jun 2024 19:47:12 +0200
Date: Fri, 28 Jun 2024 19:47:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Mark Brown <broonie@kernel.org>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Julien Stephan <jstephan@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel@pengutronix.de, T.Scherer@eckelmann.de
Subject: Re: [PATCH v2 0/5] spi: add support for pre-cooking messages
Message-ID: <Zn73IB2blUtGptpq@pengutronix.de>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
 <Zn6HMrYG2b7epUxT@pengutronix.de>
 <20240628-awesome-discerning-bear-1621f9-mkl@pengutronix.de>
 <9e6b5cff-8692-484e-9e1c-b89a1f49d6c7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e6b5cff-8692-484e-9e1c-b89a1f49d6c7@baylibre.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Hi David,

On Fri, Jun 28, 2024 at 10:27:28AM -0500, David Lechner wrote:
> Hi Oleksij and Marc,
> 
> I'm supposed to be on vacation so I didn't look into this deeply yet
> but I can see what is happening here.
> 
> spi_mux_transfer_one_message() is calling spi_async() which is calling
> __spi_optimize_message() on an already optimized message.
> 
> Then it also calls __spi_unoptimize_message() which tries to release
> resources. But this fails because the spi-mux driver has swapped
> out the pointer to the device in the SPI message. This causes the
> wrong ctlr to be passed to spi_res_release(), causing the crash.
> 
> I don't know if a proper fix could be quite so simple, but here is
> something you could try (untested):
 
Thx! I'll test it at Monday.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

