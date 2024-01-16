Return-Path: <linux-spi+bounces-489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFD782FBF6
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 23:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD141F28AA5
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AC20B0A;
	Tue, 16 Jan 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPOSfVUR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743954BC1;
	Tue, 16 Jan 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435565; cv=none; b=EqxLGd+7f/kRgDByhsM3yg8clCIYKRF0e/YpCPwuOT3DFjsSjxPtgEPtQyV8GlezZvXDzSHAKW871rXQrnNQlH6l+Wj66tPvpNRJr+P3jeuD6Dza9YlEK1g3ezphn0c3WwFpWEvQNujkXgoKNJk7j9vEkt0tL6zwL9HN29bqU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435565; c=relaxed/simple;
	bh=yNit1wLQNvcLDcN8qmNovk2/ZZbS0uStngL+tlwdEu0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=moTkoX8OjV1W1U8ylTP1cjJG+vGR12oV0OPwT2emBLMyqGVErbuuzG9eDObl8T837ACnqghsmoyXOLTY+3SjGrogMdK1zU+AXN0Il9DP8rnE97TfRI+wq8llGAM4ScnFfpnDtImU2deQ23g3jjJbthAPW8VQsr6LcdlxzCjQu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPOSfVUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9523FC433F1;
	Tue, 16 Jan 2024 20:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435565;
	bh=yNit1wLQNvcLDcN8qmNovk2/ZZbS0uStngL+tlwdEu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPOSfVURclMF+TcE+fxYy3el9v+/+X8luw+2ntVlzWKfGGsFCp/i5lDfCOvzCbLwO
	 2BXD0g3AK4AlLa9+pN7iiGhKfha7SF8xTXS2PgjMKpE8fIerZRV2nwfPUgboYduueC
	 hRI1BqwkmFgXyiYgcK+XmJ/ooWLgcU6n+0D0IagE+QrmFWxv3ouCxDdWRksSpRfs44
	 NQFzwmX6NOaFUOYOIUnnolqLqU3FwSKaDbbFox9H9UC5jDP1L7SeyS+/P8YapkNmG0
	 QrS/owSy7303qBG4NFFaMJPbKyGTeDFlkoxXeaEJcTMdRpiAeISAIxRzgEV5r+nlh0
	 OS9uoWW4/LlWg==
Date: Tue, 16 Jan 2024 20:06:00 +0000
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/33] ieee802154: ca8210: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240116200600.GI588419@kernel.org>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <66d516d935840af55e72e0530029060ae4cf399b.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66d516d935840af55e72e0530029060ae4cf399b.1705348269.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 15, 2024 at 09:12:48PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


