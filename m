Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B76048F568
	for <lists+linux-spi@lfdr.de>; Sat, 15 Jan 2022 07:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiAOGKu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 15 Jan 2022 01:10:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:19514 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbiAOGKt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 15 Jan 2022 01:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642227049; x=1673763049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=09lYREMGTg3IvgRSUeNrG9ob1eBO7V5SWbOuvFuCEEU=;
  b=NMQo3BK2NW5JbDa3Kd+1Zsm6RSZJlP2nZdjPJig/w/kHyJU3lA+9Hbq9
   kQupXR3a0KtOfzOwFtgmpI2J3/OIMYGI/zEAjYAWqDBSAI4XGRErY02OV
   vFqrZZk4DwphjgzMP8AmzC+km5T0EM93865ccWXKz8vO91ul1MuSWRAC9
   9CpVVfz0iwJ/VIBuuxXTNfKLYm6tzGOQB6Rx51rvY+kd/T+nQ7qZ0KW9y
   18xUGBTCQZsH4VV9GCeDENs+4z59MfTp8ig96pAXhiFxHtk+Jzyq5os+C
   fxmsKZK3hU+KDo6q9WWtc+bwn66/68q9B7tp5mIewRk8IKUyEZ4lDLHE0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244339852"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244339852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 22:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="624584822"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2022 22:10:46 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8cGz-0009Rp-CC; Sat, 15 Jan 2022 06:10:45 +0000
Date:   Sat, 15 Jan 2022 14:10:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Antipov <daantipov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH v3 5/5] HID: add spi-hid, transport driver for HID over
 SPI bus
Message-ID: <202201151433.04afZ5aZ-lkp@intel.com>
References: <20220115023135.234667-6-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115023135.234667-6-dmanti@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hid/for-next]
[also build test WARNING on jikos-trivial/for-next v5.16 next-20220114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Antipov/Add-spi-hid-transport-for-HID-over-SPI-bus/20220115-103254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220115/202201151433.04afZ5aZ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3773341a27b69fe38edd03823be246aa38001e6a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dmitry-Antipov/Add-spi-hid-transport-for-HID-over-SPI-bus/20220115-103254
        git checkout 3773341a27b69fe38edd03823be246aa38001e6a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/hid/spi-hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hid/spi-hid/spi-hid-core.c:203:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
     203 | static const char *const spi_hid_power_mode_string(u8 power_state)
         |        ^~~~~
--
   In file included from include/trace/define_trace.h:102,
                    from drivers/hid/spi-hid/spi-hid_trace.h:198,
                    from drivers/hid/spi-hid/trace.c:11:
   drivers/hid/spi-hid/./spi-hid_trace.h: In function 'trace_raw_output_spi_hid':
>> drivers/hid/spi-hid/./spi-hid_trace.h:144:19: warning: format '%d' expects a matching 'int' argument [-Wformat=]
     144 |         TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state i:%d p:%d len i:%d o:%d r:%d flags %c:%d",
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:399:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     399 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   drivers/hid/spi-hid/./spi-hid_trace.h:144:9: note: in expansion of macro 'TP_printk'
     144 |         TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state i:%d p:%d len i:%d o:%d r:%d flags %c:%d",
         |         ^~~~~~~~~
   In file included from include/trace/trace_events.h:433,
                    from include/trace/define_trace.h:102,
                    from drivers/hid/spi-hid/spi-hid_trace.h:198,
                    from drivers/hid/spi-hid/trace.c:11:
   drivers/hid/spi-hid/./spi-hid_trace.h:144:102: note: format string is defined here
     144 |         TP_printk("spi%d.%d: (%04x:%04x v%d) HID v%d.%d state i:%d p:%d len i:%d o:%d r:%d flags %c:%d",
         |                                                                                                     ~^
         |                                                                                                      |
         |                                                                                                      int
--
>> drivers/hid/spi-hid/trace.c:10: warning: expecting prototype for trace.c(). Prototype was for CREATE_TRACE_POINTS() instead
--
>> drivers/hid/spi-hid/spi-hid-core.c:378: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Handle the reset response from the FW by sending a request for the device


vim +203 drivers/hid/spi-hid/spi-hid-core.c

   202	
 > 203	static const char *const spi_hid_power_mode_string(u8 power_state)
   204	{
   205		switch (power_state) {
   206		case SPI_HID_POWER_MODE_ON:
   207			return "d0";
   208		case SPI_HID_POWER_MODE_SLEEP:
   209			return "d2";
   210		case SPI_HID_POWER_MODE_OFF:
   211			return "d3";
   212		case SPI_HID_POWER_MODE_WAKING_SLEEP:
   213			return "d3*";
   214		default:
   215			return "unknown";
   216		}
   217	}
   218	
   219	static void spi_hid_suspend(struct spi_hid *shid)
   220	{
   221		struct device *dev = &shid->spi->dev;
   222	
   223		if (shid->power_state == SPI_HID_POWER_MODE_OFF)
   224			return;
   225	
   226		disable_irq(shid->spi->irq);
   227		shid->ready = false;
   228		sysfs_notify(&dev->kobj, NULL, "ready");
   229	
   230		spi_hid_of_assert_reset(&shid->conf);
   231	
   232		shid->power_state = SPI_HID_POWER_MODE_OFF;
   233	}
   234	
   235	static void spi_hid_resume(struct spi_hid *shid)
   236	{
   237		if (shid->power_state == SPI_HID_POWER_MODE_ON)
   238			return;
   239	
   240		shid->power_state = SPI_HID_POWER_MODE_ON;
   241		enable_irq(shid->spi->irq);
   242		shid->input_transfer_pending = 0;
   243	
   244		spi_hid_of_deassert_reset(&shid->conf);
   245	}
   246	
   247	static struct hid_device *spi_hid_disconnect_hid(struct spi_hid *shid)
   248	{
   249		struct hid_device *hid = shid->hid;
   250	
   251		shid->hid = NULL;
   252	
   253		return hid;
   254	}
   255	
   256	static void spi_hid_stop_hid(struct spi_hid *shid)
   257	{
   258		struct hid_device *hid;
   259	
   260		hid = spi_hid_disconnect_hid(shid);
   261		if (hid) {
   262			cancel_work_sync(&shid->create_device_work);
   263			cancel_work_sync(&shid->refresh_device_work);
   264			hid_destroy_device(hid);
   265		}
   266	}
   267	
   268	static void spi_hid_error_handler(struct spi_hid *shid)
   269	{
   270		struct device *dev = &shid->spi->dev;
   271		int ret;
   272	
   273		if (shid->power_state == SPI_HID_POWER_MODE_OFF)
   274			return;
   275	
   276		if (shid->attempts++ >= SPI_HID_MAX_RESET_ATTEMPTS) {
   277			dev_err(dev, "unresponsive device, aborting.\n");
   278			spi_hid_stop_hid(shid);
   279			spi_hid_of_assert_reset(&shid->conf);
   280			ret = spi_hid_of_power_down(&shid->conf);
   281			if (ret) {
   282				dev_err(dev, "failed to disable regulator\n");
   283				shid->regulator_error_count++;
   284				shid->regulator_last_error = ret;
   285			}
   286			return;
   287		}
   288	
   289		trace_spi_hid_error_handler(shid);
   290	
   291		shid->ready = false;
   292		sysfs_notify(&dev->kobj, NULL, "ready");
   293	
   294		spi_hid_of_assert_reset(&shid->conf);
   295	
   296		shid->power_state = SPI_HID_POWER_MODE_OFF;
   297		shid->input_transfer_pending = 0;
   298		cancel_work_sync(&shid->reset_work);
   299	
   300		spi_hid_of_sleep_minimal_reset_delay(&shid->conf);
   301	
   302		shid->power_state = SPI_HID_POWER_MODE_ON;
   303	
   304		spi_hid_of_deassert_reset(&shid->conf);
   305	}
   306	
   307	static void spi_hid_error_work(struct work_struct *work)
   308	{
   309		struct spi_hid *shid = container_of(work, struct spi_hid, error_work);
   310	
   311		spi_hid_error_handler(shid);
   312	}
   313	
   314	static int spi_hid_send_output_report(struct spi_hid *shid,
   315			struct spi_hid_output_report *report)
   316	{
   317		struct spi_hid_output_buf *buf = &shid->output;
   318		struct device *dev = &shid->spi->dev;
   319		u16 report_length;
   320		u16 padded_length;
   321		u8 padding;
   322		int ret;
   323	
   324		if (report->content_length > shid->desc.max_output_length) {
   325			dev_err(dev, "Output report too big, content_length 0x%x\n",
   326							report->content_length);
   327			ret = -E2BIG;
   328			goto out;
   329		}
   330	
   331		spi_hid_populate_output_header(buf->header, &shid->conf, report);
   332	
   333		if (report->content_length)
   334			memcpy(&buf->content, report->content, report->content_length);
   335	
   336		report_length = sizeof(buf->header) + report->content_length;
   337		padded_length = round_up(report_length,	4);
   338		padding = padded_length - report_length;
   339		memset(&buf->content[report->content_length], 0, padding);
   340	
   341		ret = spi_hid_output(shid, buf, padded_length);
   342		if (ret) {
   343			dev_err(dev, "Failed output transfer\n");
   344			goto out;
   345		}
   346	
   347		return 0;
   348	
   349	out:
   350		return ret;
   351	}
   352	
   353	static int spi_hid_sync_request(struct spi_hid *shid,
   354			struct spi_hid_output_report *report)
   355	{
   356		struct device *dev = &shid->spi->dev;
   357		int ret = 0;
   358	
   359		ret = spi_hid_send_output_report(shid, report);
   360		if (ret) {
   361			dev_err(dev, "Failed to transfer output report\n");
   362			return ret;
   363		}
   364	
   365		mutex_unlock(&shid->lock);
   366		ret = wait_for_completion_interruptible_timeout(&shid->output_done,
   367				msecs_to_jiffies(1000));
   368		mutex_lock(&shid->lock);
   369		if (ret == 0) {
   370			dev_err(dev, "Response timed out\n");
   371			return -ETIMEDOUT;
   372		}
   373	
   374		return 0;
   375	}
   376	
   377	/**
 > 378	 * Handle the reset response from the FW by sending a request for the device
   379	 * descriptor.
   380	 */
   381	static void spi_hid_reset_work(struct work_struct *work)
   382	{
   383		struct spi_hid *shid =
   384			container_of(work, struct spi_hid, reset_work);
   385		struct device *dev = &shid->spi->dev;
   386		struct spi_hid_output_report report = {
   387			.report_type = SPI_HID_OUTPUT_REPORT_TYPE_DEVICE_DESC_REQUEST,
   388			.content_length = 0x0,
   389			.content_id = SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
   390			.content = NULL,
   391		};
   392		int ret;
   393	
   394		trace_spi_hid_reset_work(shid);
   395	
   396		if (shid->ready) {
   397			dev_err(dev, "Spontaneous FW reset!");
   398			shid->ready = false;
   399			sysfs_notify(&dev->kobj, NULL, "ready");
   400			shid->dir_count++;
   401		}
   402	
   403		if (shid->power_state == SPI_HID_POWER_MODE_OFF)
   404			return;
   405	
   406		if (flush_work(&shid->create_device_work))
   407			dev_err(dev, "Reset handler waited for create_device_work");
   408	
   409		if (flush_work(&shid->refresh_device_work))
   410			dev_err(dev, "Reset handler waited for refresh_device_work");
   411	
   412		mutex_lock(&shid->lock);
   413		ret = spi_hid_sync_request(shid, &report);
   414		mutex_unlock(&shid->lock);
   415		if (ret) {
   416			dev_WARN_ONCE(dev, true,
   417					"Failed to send device descriptor request\n");
   418			spi_hid_error_handler(shid);
   419		}
   420	}
   421	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
