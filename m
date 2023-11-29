Return-Path: <linux-spi+bounces-80-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C3E7FCFB3
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 08:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C3D2824EF
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 07:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9644101C9;
	Wed, 29 Nov 2023 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqFzFy0e"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B14319AB;
	Tue, 28 Nov 2023 23:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701241537; x=1732777537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1qmvHwfK7iTIDc/XSt6kxSJ8+uPc6tnRGIsBlPEG/V0=;
  b=nqFzFy0edbCqsxdsRl6wGbYg2sjXkHm4WsouPIGOR/NU49oDUrBqZi0p
   OBKhbPAtRQ8L17Ch4n4MIhN28BYwQHIU5v7tRMYoovpCilPx5J3pi6Rn0
   0WmfIvtRWcy5/OakgOhJqQ99ZiZ5gbd01pmekjlcEC+AuMWXxMB/IOEsk
   O2utbrNYfv6eEp04U63CQPjA95TyfL60IjdisP46HXToCY5RVAeECXn6V
   eLOxqb55aY+KDr85U1xe59gXfVZs2jutUhB41gqI6QKG0cyJ+KOuzmDXA
   lghSGzLETHqSleqKswX6gt/M63hEar+M5ByBwPf+o/6eQYtfcSSqKezsR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="391977373"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="391977373"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 23:05:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="772585802"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="772585802"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2023 23:05:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 6B64023A; Wed, 29 Nov 2023 09:05:31 +0200 (EET)
Date: Wed, 29 Nov 2023 09:05:31 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>,
	linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Mario Kicherer <dev@kicherer.org>,
	Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP
 with -EOPNOTSUPP
Message-ID: <20231129070531.GP1074920@black.fi.intel.com>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>

On Wed, Nov 29, 2023 at 02:43:10PM +0800, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> This commit updates the SPI subsystem, particularly affecting "SPI MEM"
> drivers and core parts, by replacing the -ENOTSUPP error code with
> -EOPNOTSUPP.
> 
> The key motivations for this change are as follows:
> 1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
> might return ENOTSUPP. This update aims to unify the error reporting
> within the SPI subsystem for clarity and consistency.
> 
> 2. The use of ENOTSUPP has been flagged by checkpatch as inappropriate,
> mainly being reserved for NFS-related errors. To align with kernel coding
> standards and recommendations, this change is being made.
> 
> 3. By using EOPNOTSUPP, we provide more specific context to the error,
> indicating that a particular operation is not supported. This helps
> differentiate from the more generic ENOTSUPP error, allowing drivers to
> better handle and respond to different error scenarios.
> 
> Risks and Considerations:
> While this change is primarily intended as a code cleanup and error code
> unification, there is a minor risk of breaking user-space applications
> that rely on specific return codes for unsupported operations. However,
> this risk is considered low, as such use-cases are unlikely to be common
> or critical. Nevertheless, developers and users should be aware of this
> change, especially if they have scripts or tools that specifically handle
> SPI error codes.
> 
> This commit does not introduce any functional changes to the SPI subsystem
> or the affected drivers.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

