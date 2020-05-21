Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE11DCCAA
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgEUMOX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 08:14:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:5175 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbgEUMOW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 08:14:22 -0400
IronPort-SDR: HiyzefAXvFyNDzbb+e9dy8/clmrwIfB7ubXZDO2bf5AwVJ5MsQ4zlPa5ctcGx5/W9WTHTD/UNW
 V0zZGYMcUhQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 05:14:12 -0700
IronPort-SDR: MFQk67iCXel4hNSRiGw0kw3tkSFQSs0WGWIE0LscF3gapHDp7VHSj1sMLjVmuLywmuKyIbkWIl
 2i7szTVcA3ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="466762230"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 21 May 2020 05:14:11 -0700
Received: from [10.215.164.158] (vramuthx-mobl1.gar.corp.intel.com [10.215.164.158])
        by linux.intel.com (Postfix) with ESMTP id AD60A5804B4;
        Thu, 21 May 2020 05:14:05 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 1/1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200520124329.GF4823@sirena.org.uk>
 <fd086da7-7e18-83bc-d423-56095b0cff96@linux.intel.com>
 <20200521105646.GA4770@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <24b0297c-5c33-f690-9514-68b76fc2c9ea@linux.intel.com>
Date:   Thu, 21 May 2020 20:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521105646.GA4770@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Mark,

On 21/5/2020 6:56 pm, Mark Brown wrote:
> On Thu, May 21, 2020 at 10:18:26AM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 20/5/2020 8:43 pm, Mark Brown wrote:
>>> On Wed, May 20, 2020 at 08:36:12PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> 
>>>>    .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>>>>    .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 133 +++++++++++++++++++++
> 
>>> The changelog says this is adding a new binding but the actual change is
>>> mostly a conversion to YAML.  Please split the additions out into a
>>> separate change, ideally doing that before the conversion since there is
>>> a backlog on review of YAML conversions.
> 
>> Initially was sending the only YAML file alone, then reviewers suggest to me
>> do this way so I did, next by split the patches like below...
> 
>> 1. remove the cadence-quadspi.txt (patch1)
>> 2. convert txt to YAML (patch2)
> 
> That doesn't address either of the issues.  The removal of the old
> bindings and addition of the YAML ones needs to be in a single patch
> doing that conversion.  What I'm suggesting should be done separately is
> whatever changes to the semantics of the bindings you are (according to
> your changelog) doing.
You mean semantics of the binding as a single patch you are suggesting 
me, right? , Thanks!

Regards
Vadivel

> 
