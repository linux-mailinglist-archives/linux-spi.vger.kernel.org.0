Return-Path: <linux-spi+bounces-487-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DB82FBF4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 23:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3490628D569
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 22:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903767C6E;
	Tue, 16 Jan 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZu6MsPG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115067C67;
	Tue, 16 Jan 2024 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435524; cv=none; b=UdYWHKYzRlmoA5nzaTDSSEO6xLVQ43FtBTK9wE3OIWFcyAUyWd3f8SfU4ly0dwaWB2PQw9C/oVf8TIp3YY8+056+ZowmrSsOrMQJUpk4BAwY1H8LlOd1rUrUJSPsuPnT9bxZJePD5va1iIsnD82j9OJW5C0yZV1SFXH08vGZ/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435524; c=relaxed/simple;
	bh=FRXMq8sEeMDB3f4/buWJMZgI4gfDtQb2e45HXr4pu3k=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=G9FYk126brnyYRwOQrKDNa6TcjFpzDMUpo63oMk9RjFz10Fc6G7GN6YlDWZdPsIzQilKBKlBREVug0os/Y333MFUrvuaYDSrdcza69xbNaYwf/S4JBclK9gFfvYIkBEWJQtUAaS5/kJMpDFxBoN4brjH7V6oGhcHE9V191dzyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZu6MsPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0767C43390;
	Tue, 16 Jan 2024 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435523;
	bh=FRXMq8sEeMDB3f4/buWJMZgI4gfDtQb2e45HXr4pu3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZu6MsPGvp3Is26EOKON44OXpqitaYROrAltLgRn/2XGmqJInlR+rR3ONd24Lkylu
	 QBzq9kfieHgnALGxhOy6SARiq7RPEIRTfDz1hqpwKw3KcffYwwFxVvTBjaES7JSMNA
	 hXmJJRhRvue0XTAM+XFEw6IJAhloNXz5CcDK370pwRdEcFUJ+YvpySp48yw2WPkJAt
	 TRS/L7RoiJgfqX127hUHWVDgVwlnEl4klaCaKrqDWonC0D11grh/1AEGlxSa+V9aXY
	 BFYNvwRE0EcTVWkGbaeQ7AkTohevjICOb6Aq9hhhEDf9Wrr1DvoBFYoyKQAduwi2BM
	 5LMbHbAe1ycyg==
Date: Tue, 16 Jan 2024 20:05:19 +0000
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 15/33] net: vertexcom: mse102x: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240116200519.GG588419@kernel.org>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <a7ca57cfa5b63e5c70824c24fb1bca1eba8cb087.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ca57cfa5b63e5c70824c24fb1bca1eba8cb087.1705348269.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 15, 2024 at 09:13:01PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


