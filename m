Return-Path: <linux-spi+bounces-7887-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F451AA9486
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9B73B38C5
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5044125A2BB;
	Mon,  5 May 2025 13:28:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D0258CCC
	for <linux-spi@vger.kernel.org>; Mon,  5 May 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451739; cv=none; b=Vx9DVPsXOPbSO9RhuwCqZ/VkVy+hxoaqUZAaQT4OgEKvyNimo4JML06hZdkdj6OO49u5HRyjFAtDKxCeBTxF7bJ9v/QcIvRmTULqjWqokTvLryAhcac1UcAWcIher2KPGEEX4Ugpx/TmT+jds9+fYghBrAg3DFDYqfRex49RNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451739; c=relaxed/simple;
	bh=dZ9dBgvKwfKcr/rfkOtP60IfI258WLh7fJ/cniyVNIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDYSAnbnQS15N9waIC3zaElU+DdsMz8Qs/YLrAICiFLU+unUbrEmDOveIw2asBgYT5fmTXeTzO4xGE7HWCN3i6j+fqNFzwnoV5Eo8GM6E9xz+puMxOfMMQYatIlo6WBlTw2Qs7k508qm6FNWmdsmG6Biy/0WpM7iP9OU8kFhoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uBvsK-0001cN-La; Mon, 05 May 2025 15:28:52 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uBvsJ-001Em3-1x;
	Mon, 05 May 2025 15:28:51 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uBvsJ-000Kk2-1h;
	Mon, 05 May 2025 15:28:51 +0200
Message-ID: <1431aa0cb021da0056b9de594c3332045b770d07.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] reset: Add
 devm_reset_control_array_get_exclusive_released()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Patrice Chotard <patrice.chotard@foss.st.com>, Mark Brown
 <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 05 May 2025 15:28:51 +0200
In-Reply-To: <20250411-b4-upstream_ospi_reset_update-v2-1-4de7f5dd2a91@foss.st.com>
References: 
	<20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com>
	 <20250411-b4-upstream_ospi_reset_update-v2-1-4de7f5dd2a91@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

On Fr, 2025-04-11 at 14:41 +0200, Patrice Chotard wrote:
> Add the released variant of devm_reset_control_array_get_exclusive().
> Needed by spi-smt32-ospi driver as same reset line is ulso used by
> stm32-omm driver.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied patch 1 to reset/next, thanks!

[1/2] reset: Add devm_reset_control_array_get_exclusive_released()
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D6b3754009f87

regards
Philipp

