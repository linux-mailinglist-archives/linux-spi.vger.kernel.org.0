Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB426455B3F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 13:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbhKRMM3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 07:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344522AbhKRMM1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 07:12:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46675613B1;
        Thu, 18 Nov 2021 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637237367;
        bh=vTc7gyH6B+jCfzlmBr6QVgg81p6LYBnt9/FZaldxVh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkemVrpH3KgutAOA8RPVxJss5CnZYYBjtzrehAf8bvshsBZ7xsuv6xPiZysNNSBEt
         vhTRGtBtq9irHiF/bXpNYhUqtY85hTzUu8+aY18wjrOHKQG0nGEvNURXB6yN1hkO1U
         TqKfhqdXzOZLUnyZw6O2Oe5MlWYAdM0kDzAZXuWwYhEca4ZOTwiDWcUX4+Cztl7sjA
         m0eSnrZqg63p+eCxoWgmK0CsvFmEPfwMlPFWpIcBDM9ydAT8jsUPPrQa1vqrQUh2Jt
         +55bTKOsudJPXj+jncKU+rpcOjVhI9rEAsuRrEleP71Mm9jZGtHyzC+CoXnMNsYkGL
         fxvpuf79bMerA==
Date:   Thu, 18 Nov 2021 12:09:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: qcom: geni: set the error code for gpi transfer
Message-ID: <YZZCc2DDxJhTfA5I@sirena.org.uk>
References: <20211117133110.2682631-1-vkoul@kernel.org>
 <20211117133110.2682631-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uX22MhuhZ3wmiD3M"
Content-Disposition: inline
In-Reply-To: <20211117133110.2682631-2-vkoul@kernel.org>
X-Cookie: People respond to people who respond.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uX22MhuhZ3wmiD3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 17, 2021 at 07:01:09PM +0530, Vinod Koul wrote:
> Before we invoke spi_finalize_current_transfer() in
> spi_gsi_callback_result() we should set the spi->cur_msg->status as
> appropriate (0 for success, error otherwise).

Fixes should come at the start of the patch series to make sure they can
be applied as fixes without pulling in anything else.

--uX22MhuhZ3wmiD3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGWQnIACgkQJNaLcl1U
h9B6AQf+JglmmKD8Jw1wEnvRgBZCgNXB5rnObe53RwuURkNIFRwzpa0uTvUCDqHm
2ynwnEdYuogeX+TiXlTrSXJ0XMReawjaKiVFihaZOvr9UHi2oIvqr2VFWWFtl7TZ
LJtKCNLNe8XlgBU8dBqnE/0HHN01YfLty8CqMppoEtUDOt8ft+O1KyTGbvrJ9YbI
KGPCjFn1qMd/qOhjd+EiUzOFmA7NVqO+lmmj7rbJ/JLLm6IDJ5FIs8qRebFS5V6J
hnnBN2VIRyyrbOg0XsCXQmaxeyYIvG+SHalhfe61VgDRUt86Gt/kcXxeQDMG1CUp
8m9+7uw5nAtP6l/hxekEko0nfPUzeA==
=+hVN
-----END PGP SIGNATURE-----

--uX22MhuhZ3wmiD3M--
