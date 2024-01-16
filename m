Return-Path: <linux-spi+bounces-488-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98E82FBFF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 23:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B34B25D04
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFBE67C68;
	Tue, 16 Jan 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgSwaamn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516D20B0A;
	Tue, 16 Jan 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435539; cv=none; b=JRlzl37Udy4qe0yGA+uCO5r0JGkmmiSW0d9Avky9L9PFMeK4JQBYfTMgUOK06gb8kEKgnqVQHv2zSlLSHA1hzdlYeqhZDmlDYB/ouzhWHRU6cId1JqhdR8Fr6kQf2VvVT3+6wHaKc+NJlKBqicCHk1RFRjcZlKHfCnbWxxlIHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435539; c=relaxed/simple;
	bh=1oF1Qy3nl0+RJlEKX8yy4OMn8DjK0UKFj1OEk5hyfM8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=hzWK0o0QhERyA26OFzqqBEq/gwaXUPy8T+VDG+1IKJNh5Y/h4pgsyjIOo5fltCV3qC0P+yXX99QVDYvVVnkJjc8cwEAls2ZjAx6J92sEjDxpsrn8M3pWo89Zp294V+7OxK7qZrl3bvhfUw6G3HTaSQ6eX92f9zDWtMv+dzNtqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgSwaamn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06AAC433F1;
	Tue, 16 Jan 2024 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435538;
	bh=1oF1Qy3nl0+RJlEKX8yy4OMn8DjK0UKFj1OEk5hyfM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgSwaamnUjgEHRxFqc8Kxw36vkp49iiHhdrT3RmpNy6gaVD4hDcKtOPwlSAftfJLA
	 xBON+jezp2pESJsQt7k2ZYlaolRyCV7QZWC+Czx1vNU9j8LuLW09jL2kLz9IdbpT2x
	 eAOHvlSPe7IIbK1RJq8Em0hS/drhryFcPTDEaqo2ayZmYYQkApg847N34no29GlTex
	 esmFtCtlCgAQvdnvPP2UfIEfblSWv5od7hEM/uKw0Y/BCEhx3wdgd5EdSWv9/pouO2
	 tbPmVrj+7UDFkTsAbsRUVt2yBq5EC/LvoGuPlGgphypn3lhmINhYpM/nW4idYBi1NK
	 S6iDaB39YqLJA==
Date: Tue, 16 Jan 2024 20:05:33 +0000
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ronald Wahl <ronald.wahl@raritan.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 14/33] net: ks8851: Follow renaming of SPI "master" to
 "controller"
Message-ID: <20240116200533.GH588419@kernel.org>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <9d509f1065bd6fdf673022b46cb3e7e7faabf38d.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d509f1065bd6fdf673022b46cb3e7e7faabf38d.1705348269.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 15, 2024 at 09:13:00PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


