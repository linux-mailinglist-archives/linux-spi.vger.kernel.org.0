Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D97CA15F
	for <lists+linux-spi@lfdr.de>; Mon, 16 Oct 2023 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjJPINr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Oct 2023 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjJPINp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Oct 2023 04:13:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36235EA;
        Mon, 16 Oct 2023 01:13:44 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389332440"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389332440"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749210426"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="749210426"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:13:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andy@kernel.org>)
        id 1qsIjK-00000005xJM-42Nn;
        Mon, 16 Oct 2023 11:13:38 +0300
Date:   Mon, 16 Oct 2023 11:13:38 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec
 info for Lenovo Yoga Tab 3 Pro YT3-X90F
Message-ID: <ZSzwslha2aUGod7A@smile.fi.intel.com>
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
 <65cb8c8c-1a07-922b-db7a-dba54afc76b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb8c8c-1a07-922b-db7a-dba54afc76b6@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 15, 2023 at 11:15:47AM +0200, Hans de Goede wrote:
> On 10/14/23 22:53, Hans de Goede wrote:

> > +        .micbias={
> > +           [0]={ /*MICBIAS1*/

Talking about spaces, how about

        .micbias = {
           [0] = { / *MICBIAS1 */
                 .mV = 2800 ,
                 .ext_cap = 1,
                 .discharge = 1 ,
                 .soft_start = 0,
                 .bypass = 0,

> > +                 .mV =2800 ,
> > +                 .ext_cap=1,
> > +                 .discharge =1 ,
> > +                 .soft_start =0,
> > +                 .bypass =0,
> > +           },
> 
> Note I messed up the indentation here (spaces instead of tabs)
> when copy pasting this from one terminal to another,
> I'll go and fix this up locally.

-- 
With Best Regards,
Andy Shevchenko


