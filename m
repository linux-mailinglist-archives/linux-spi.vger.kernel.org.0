Return-Path: <linux-spi+bounces-7524-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6768A843A8
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B92616930F
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693CE1F1505;
	Thu, 10 Apr 2025 12:48:43 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78D2836B0
	for <linux-spi@vger.kernel.org>; Thu, 10 Apr 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289323; cv=none; b=njiQJztvOQxOOB1lFxPpGREsV6myBocobjWO1s6eWcLJLjxpp7vu5jI+VTPvPgFxvnCiuw7bBQ6pRrRA0jgmSxuEtSOjQZy/nl1IdehFsnoJHiMlHtA9/MBwUiw6alNZhv5q8RlIS3UmrdwOcOTZrxv0WcOxuR/FK8Q2w0rdCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289323; c=relaxed/simple;
	bh=MmRI+FetTM2eAyt9N5xGOIpCM3ckX224r/9FqwUbN4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gwje4n6+dzyNbsjYTBUpQmhlHpEJlkuRF0KE+ban5vLYuSoVtG/bu+4SBnWXlN2VnulBv7zq1wQ/R1V6wrk5MCHfX85yn6V3D+zFN8U2B+jZlYfa2+W5mh4vesgv9IG/y0Xv4lqxY2EAiiLYEKTc2wd3MzbXrCUAhY/n2tgy2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1u2rKe-00088G-VA; Thu, 10 Apr 2025 14:48:36 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1u2rKe-004Gv3-2S;
	Thu, 10 Apr 2025 14:48:36 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1u2rKe-00095Z-2B;
	Thu, 10 Apr 2025 14:48:36 +0200
Message-ID: <a0f9115f66ff2993ff8dcce768a071dccb011579.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] reset: Add
 devm_reset_control_array_get_exclusive_released()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Patrice Chotard <patrice.chotard@foss.st.com>, Mark Brown
 <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 10 Apr 2025 14:48:36 +0200
In-Reply-To: <20250410-b4-upstream_ospi_reset_update-v1-1-74126a8ceb9c@foss.st.com>
References: 
	<20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com>
	 <20250410-b4-upstream_ospi_reset_update-v1-1-74126a8ceb9c@foss.st.com>
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

On Do, 2025-04-10 at 14:23 +0200, Patrice Chotard wrote:
> Add the released variant of devm_reset_control_array_get_exclusive().
> Needed by spi-smt32-ospi driver as same reset line is ulso used by
> stm32-omm driver.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  include/linux/reset.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 2986ced69a026947c8aafa89cdddf1e4088caef7..840d75d172f6239540bd12ab7=
01103b7f02a624b 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -1004,6 +1004,12 @@ devm_reset_control_array_get_exclusive(struct devi=
ce *dev)
>  	return devm_reset_control_array_get(dev, RESET_CONTROL_EXCLUSIVE);
>  }
> =20
> +static inline struct reset_control *
> +devm_reset_control_array_get_exclusive_released(struct device *dev)
> +{
> +	return devm_reset_control_array_get(dev, RESET_CONTROL_EXCLUSIVE_RELEAS=
ED);
> +}

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

But this might not even be necessary, see next patch.

regards
Philipp

