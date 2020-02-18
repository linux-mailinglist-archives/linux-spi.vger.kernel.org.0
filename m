Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88129161F66
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 04:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgBRDRQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 22:17:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:16883 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRDRQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 22:17:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 19:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="314932496"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2020 19:17:15 -0800
Received: from [10.226.38.30] (unknown [10.226.38.30])
        by linux.intel.com (Postfix) with ESMTP id ADD2A580270;
        Mon, 17 Feb 2020 19:17:12 -0800 (PST)
Subject: Re: [PATCH v9 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214130952.GI4827@sirena.org.uk>
 <3530edcd-eb67-8ea5-0fce-89c83400441c@linux.intel.com>
 <20200217170901.GS9304@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <debe614e-e5fe-edd4-8890-1b993d605f85@linux.intel.com>
Date:   Tue, 18 Feb 2020 11:17:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200217170901.GS9304@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 18/2/2020 1:09 AM, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 05:18:10PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 14/2/2020 9:09 PM, Mark Brown wrote:
>>> This will unconditionally handle the interrupt regardless of if the
>>> hardware was actually flagging an interrupt which will break shared
>>> interrupts and the fault handling code in genirq.
>> Yes, you're correct, it doesn't check unconditionally, will update the
>> INT flag in the INT_STATUS register after successful completion of
>> read/write operation.
>> but in this case it is dedicated to qspi-interrupt,not shared with any other
>> HW/SW interrupts.
> Currently, on the system you're looking at.  Given that this is already
> a widely reused IP there's no guarantee that this will always be the
> case, and like I say even without sharing it also defeats the fault
> handling code.
Got it, Thanks! a lot
will take care of it, even though it is not present in the system 
current,  to avoid future conflicts.
Flagging and check to be added  to avoid  if the interrupt raises from 
shared  devices.

Regards
Vadivel
