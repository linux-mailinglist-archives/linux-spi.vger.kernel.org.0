Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1FC160FA7
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 11:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgBQKLU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 05:11:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:55528 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgBQKLU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 Feb 2020 05:11:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 02:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="229155040"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2020 02:11:18 -0800
Received: from [10.226.38.21] (unknown [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id EEE77580270;
        Mon, 17 Feb 2020 02:11:15 -0800 (PST)
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <48e60c06-62d5-4965-97d1-51577da3bbcf@linux.intel.com>
Date:   Mon, 17 Feb 2020 18:11:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Simon,

On 14/2/2020 8:02 PM, Simon Goldschmidt wrote:
> On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> Add support for the Cadence QSPI controller. This controller is
>> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
>> This driver has been tested on the Intel LGM SoCs.
> This is v9 and still, none of the altera maintainers are on CC?
> How will it be ensured that this doesn't break altera if it is merged?
Thanks for reminded me, sorry, next send time will add them in CC.

Regards
Vadivel
>
> Regards,
> Simon
>
