Return-Path: <linux-spi+bounces-2866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD098C778D
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573E7B21628
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34F146D5A;
	Thu, 16 May 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kccyz/FO"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E9146A81;
	Thu, 16 May 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865941; cv=none; b=VLgdCPTy9wstWr8HFum15Hj2+rkn4BWQux0XjburIK1Uq2pnSulI7YgCqswAug7SJ3eEbPzIj1iqM75KTUR5KPiHeqP2cedE/TdSiQiRkpTZMDZhrODrTW5FsQuWa1lX/torlJGoQCtWW4G6mUyl2LaoxxBfd1BbUyU0Rv5TQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865941; c=relaxed/simple;
	bh=VsIJoVcpaZyxPjmMbwNyKsbaFel46KmodWVxSzdH2w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIa8VcX57JvPXWdHAGvuUC0r5rST+cWk3Vjg1ymiKgyd3zi3xEvvxSgAHDLyUzbqgG+BR5AP9NqlWu2dbT62IK0cB8h1gedPuHRgaRTooWigxJPRwdM9FmNSBs2zAV1L4xI5hBiokr/sfsI0Km3Bs8DAcFJcVxrriKVtWhpbTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kccyz/FO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715865939; x=1747401939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VsIJoVcpaZyxPjmMbwNyKsbaFel46KmodWVxSzdH2w4=;
  b=Kccyz/FO5T9ZMHvP59DrYNIQxDMonL+W760y9xTaPff4c4TiQEnMTUbK
   yKujA52kjWVa92qp6hUbVjh9w6ZFxUuspJvVGjMZOaJ33iQsleQuDvLfH
   2CBszLdWnX5D9M72mG6sUn2UlxfdIultWdPTU/GVGQcO5+Yc/h8v/E36u
   WhyBKeYtc9G17vS/K4QEqlviGRTb+jjdoahtIlI2AlDUU93WkGHFqHOhb
   WUrk9/DLGKkYmHjwfuvlSU2UnnxDy1M5EHqXASUY038SwhabqqJtNiaAf
   9HQy1sQP//oGy6Id/L85IhEmmhe+46X6UZpdgae1cSeHWQVYWRk5J3fuL
   g==;
X-CSE-ConnectionGUID: +z4ecAtmTtuELf47/CqfRw==
X-CSE-MsgGUID: ewSu32urTsGX2eTmKHh+iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11820516"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11820516"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:25:39 -0700
X-CSE-ConnectionGUID: Xqgw/h7JQLiUdWj4pIljFw==
X-CSE-MsgGUID: 7xPasMA7RPyI3ILjZwM1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35861237"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:25:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7b71-000000083vS-1Blf;
	Thu, 16 May 2024 16:25:35 +0300
Date: Thu, 16 May 2024 16:25:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <ZkYJTxmlM5oWOzFL@smile.fi.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <ZkXdXO4Xb83270V7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkXdXO4Xb83270V7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 16, 2024 at 01:18:04PM +0300, Andy Shevchenko wrote:
> On Wed, May 15, 2024 at 05:09:33PM -0400, Nícolas F. R. A. Prado wrote:
> > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > have checks for orig_nents against 0. No need to duplicate this.
> > > All the same applies to other DMA mapping API calls.
> > > 
> > > Also note, there is no other user in the kernel that does this kind of
> > > checks.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > this commit caused a regression which I reported here:
> > 
> > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > 
> > along with some thoughts on the cause and a possible solution, though I'm not
> > familiar with this code base at all and would really appreciate any feedback you
> > may have.
> 
> Thanks for the report and preliminary analysis!
> I'll look at it hopefully sooner than later.
> 
> But at least what I think now is that my change revealed a problem somewhere
> else, because that's how DMA mapping / streaming APIs designed, it's extremely
> rare to check orig_nents field.

Can you test the below patch?

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2efd4964f7c..51811f04e463 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1243,6 +1243,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	else
 		rx_dev = ctlr->dev.parent;
 
+	ret = -ENOMSG;
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* The sync is done before each transfer. */
 		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
@@ -1272,6 +1273,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			}
 		}
 	}
+	/* No transfer has been mapped, bail out with success */
+	if (ret)
+		return 0;
 
 	ctlr->cur_rx_dma_dev = rx_dev;
 	ctlr->cur_tx_dma_dev = tx_dev;


If it fixes the issue, I will submit it properly.

-- 
With Best Regards,
Andy Shevchenko



