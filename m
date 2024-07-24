Return-Path: <linux-spi+bounces-3988-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843E93B7E2
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 22:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B8D2861CE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 20:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575615F402;
	Wed, 24 Jul 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j30C3brh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669873509;
	Wed, 24 Jul 2024 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852143; cv=none; b=fCscfk9aw8cNshIYooP+DwL1zLNGMZvavPjl5Vs5gB3EWZGEwmu075Q/Kc59972Lia5G4HELL+pME2NOPB7YGvoLaiiVNkANh7UG8WFDPjprgWmmokyH05tD8SjNstPxhG/8aJMRdDt4Z/MKPt1sryetN/QFkTNdPsgaPBSO8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852143; c=relaxed/simple;
	bh=7nXzHDV1fxOOOmXNYkOQZk9rfzCSrtSpWQi7+Sgl3yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTPhZZD6XObmD3uOU6aCQ3i5AUZIoOgCyg51gYrKTQFePOKFN+Z2XIfvGfdTGI1lyiUmCnSUMtfPbtI9qC1EuqIeO9/Q7P4Ns2ay9d1MGlIhLCP/XpfdWpHplvNSK49hyEP4n39BkmDI+jfww+O+rN5bzH/7CxSFWN+l6pK7uyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j30C3brh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721852142; x=1753388142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7nXzHDV1fxOOOmXNYkOQZk9rfzCSrtSpWQi7+Sgl3yg=;
  b=j30C3brhHAZ0648cp0+WttfkE/cXqcs8hgrgvoyuqDSW9VdQeuOMg3w2
   hPttvv59nZwCplUfFKlE0e37NzceHgR+L54Yt6xNCLPSU9XxHUsFysr5a
   CFQuRjQWVls/sVCko18NRkb7cu0AXJEeKMzIGGMy7vJNLzukyzty1DYDC
   zI+Xg+pe8zppPkDtj/GX/DVTcxuL29qXKxuG6ybcOxo24bNKbYvPgVFy1
   ms613qa61bH44SHyhO0O82bPvmAqKhifkf5znfdvZ9fk3DjtaQSLWWYc+
   IpoX1+rECZapJxkFaddcw1wg8yDmyBxBYeGN8YA7bATjshh7+en5G7T0p
   A==;
X-CSE-ConnectionGUID: Yb4y+Q6LQaCVWMl6ztrcdQ==
X-CSE-MsgGUID: U6iFwbvARUaTJGCIO2zA1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30948629"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30948629"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 13:15:41 -0700
X-CSE-ConnectionGUID: OIW3Vw1jSh2WDXTU5oqssw==
X-CSE-MsgGUID: QfmoQIcFTyC6ZCHVCEMiZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="75928078"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Jul 2024 13:15:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWiOb-000nOq-2v;
	Wed, 24 Jul 2024 20:15:33 +0000
Date: Thu, 25 Jul 2024 04:15:17 +0800
From: kernel test robot <lkp@intel.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, esben@geanix.com,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, quic_mdalam@quicinc.com,
	quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: [PATCH v7 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
Message-ID: <202407250425.0AJoHyHa-lkp@intel.com>
References: <20240724114225.2176448-3-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724114225.2176448-3-quic_mdalam@quicinc.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on broonie-spi/for-next robh/for-next linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/spi-dt-bindings-Introduce-qcom-spi-qpic-snand/20240724-195819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240724114225.2176448-3-quic_mdalam%40quicinc.com
patch subject: [PATCH v7 2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
config: i386-buildonly-randconfig-004-20240725 (https://download.01.org/0day-ci/archive/20240725/202407250425.0AJoHyHa-lkp@intel.com/config)
compiler: gcc-8 (Ubuntu 8.4.0-3ubuntu2) 8.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407250425.0AJoHyHa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407250425.0AJoHyHa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/qcom_nandc.c:682: warning: Function parameter or struct member 'chip' not described in 'nandc_set_read_loc_first'
>> drivers/mtd/nand/raw/qcom_nandc.c:710: warning: Function parameter or struct member 'chip' not described in 'nandc_set_read_loc_last'


vim +682 drivers/mtd/nand/raw/qcom_nandc.c

   669	
   670	/**
   671	 * nandc_set_read_loc_first() - to set read location first register
   672	 * @reg_base:		location register base
   673	 * @cw_offset:		code word offset
   674	 * @read_size:		code word read length
   675	 * @is_last_read_loc:	is this the last read location
   676	 *
   677	 * This function will set location register value
   678	 */
   679	static void nandc_set_read_loc_first(struct nand_chip *chip,
   680					     int reg_base, int cw_offset,
   681					     int read_size, int is_last_read_loc)
 > 682	{
   683		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   684		int val = (((cw_offset) << READ_LOCATION_OFFSET) |
   685			  ((read_size) << READ_LOCATION_SIZE) |
   686			  ((is_last_read_loc) << READ_LOCATION_LAST));
   687	
   688		if (reg_base == NAND_READ_LOCATION_0)
   689			nandc->regs->read_location0 = val;
   690		else if (reg_base == NAND_READ_LOCATION_1)
   691			nandc->regs->read_location1 = val;
   692		else if (reg_base == NAND_READ_LOCATION_2)
   693			nandc->regs->read_location2 = val;
   694		else if (reg_base == NAND_READ_LOCATION_3)
   695			nandc->regs->read_location3 = val;
   696	}
   697	
   698	/**
   699	 * nandc_set_read_loc_last - to set read location last register
   700	 * @reg_base:		location register base
   701	 * @cw_offset:		code word offset
   702	 * @read_size:		code word read length
   703	 * @is_last_read_loc:	is this the last read location
   704	 *
   705	 * This function will set location last register value
   706	 */
   707	static void nandc_set_read_loc_last(struct nand_chip *chip,
   708					    int reg_base, int cw_offset,
   709					    int read_size, int is_last_read_loc)
 > 710	{
   711		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
   712	
   713		int val = (((cw_offset) << READ_LOCATION_OFFSET) |
   714			  ((read_size) << READ_LOCATION_SIZE) |
   715			  ((is_last_read_loc) << READ_LOCATION_LAST));
   716	
   717		if (reg_base == NAND_READ_LOCATION_LAST_CW_0)
   718			nandc->regs->read_location_last0 = val;
   719		else if (reg_base == NAND_READ_LOCATION_LAST_CW_1)
   720			nandc->regs->read_location_last1 = val;
   721		else if (reg_base == NAND_READ_LOCATION_LAST_CW_2)
   722			nandc->regs->read_location_last2 = val;
   723		else if (reg_base == NAND_READ_LOCATION_LAST_CW_3)
   724			nandc->regs->read_location_last3 = val;
   725	}
   726	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

