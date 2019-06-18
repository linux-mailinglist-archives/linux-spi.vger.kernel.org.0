Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7014049C27
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfFRIii (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 04:38:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfFRIii (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Jun 2019 04:38:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F1F28;
        Tue, 18 Jun 2019 01:38:37 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9CE3F246;
        Tue, 18 Jun 2019 01:38:36 -0700 (PDT)
Subject: Re: [PATCH v2 09/28] drivers: Add generic match helper by
 ACPI_COMPANION device
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, broonie@kernel.org
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-10-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0gi2vpr5y3USnPnPBHjPA1YAwfqjsJppfLgBP5CcycGog@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <85f942fc-52fd-c4ed-29b3-f28c55a6a7bb@arm.com>
Date:   Tue, 18 Jun 2019 09:38:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gi2vpr5y3USnPnPBHjPA1YAwfqjsJppfLgBP5CcycGog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rafael,

On 17/06/2019 23:07, Rafael J. Wysocki wrote:
> On Fri, Jun 14, 2019 at 7:55 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Add a generic helper to match a device by the ACPI_COMPANION device.
>> This will be later used for providing wrappers for
>> (bus/class/driver)_find_device().
>>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-spi@vger.kernel.org
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Please fold this change into the patch adding users of device_match_acpi_dev().

There are variants of this by class/bus/driver and all of them are introduced
as separate patches with the respective users. If we do for this, we have to
do the same for other matches as well.

i.e, [ device_match_by_attr + class_find_device_by_attr & users + 
driver_find_device_by_attr & users + bus_find_device_by_attr & users ]

And that becomes a large chunk, which could make the review painful.

If you would still like that approach, I could do that in the next revision.

Cheers
Suzuki
